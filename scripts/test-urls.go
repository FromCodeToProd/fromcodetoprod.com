package main

import (
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"regexp"
)

func main() {
	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "Usage: %s [base URL]\n", os.Args[0])
		flag.PrintDefaults()
	}
	flag.Parse()

	baseURL := flag.Arg(0)
	if baseURL == "" {
		fmt.Fprintf(flag.CommandLine.Output(), "base URL argument is required.\n\n")
		flag.Usage()
		os.Exit(2)
	}

	testURLs(baseURL)
}

func testURLs(baseURL string) {
	u, err := url.Parse(baseURL)
	if err != nil {
		log.Fatal(err)
	}

	for path, re := range map[string]*regexp.Regexp{
		"/episodes/index.rss": regexp.MustCompile(`^<rss`),
	} {
		url := u.ResolveReference(&url.URL{
			Path: path,
		})
		if err = testURL(url.String(), re); err != nil {
			log.Printf("%s: %s", url, err)
		}
	}
}

func testURL(url string, re *regexp.Regexp) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	if !re.Match(b) {
		return errors.New("unexpected content")
	}
	return nil
}
