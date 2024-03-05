# Randnews

Randnews is a made-for-fun tool for generating random news headers via [Markov chains](https://en.wikipedia.org/wiki/Markov_chain).
Current news sources include the following websites:
## UA
- [НВ](https://nv.ua/ukr/)
- [Українська правда](https://www.pravda.com.ua/)
- [ukr.net](https://www.ukr.net/)
- [fun.24tv.ua](https://fun.24tv.ua/)

## Prerequisites

In order to be able to launch the tool you need to have Elixir (tested
on 1.16.0) + recent OTP installed.

## Usage

Main functions of the Randnews tool are accessible via the Mix
task of the same name. It has two main modes of operation: getting real news headers and
generating new random ones.

### Generating a file with news headers

In order to generate such file from the news sources listed in the
description above you need to execute the following command:
```
mix randnews dump [options]
```
It has a shortcut version, "d" instead of "dump".
The possible options are:
- -f or --file, for a custom path for the file to be generated. By
  default it is "news.txt" in the current working directory
- -n or --count, used for indicating approximate desired count of news
  to be fetched for every news source. Defaults to 50
- -h or --help, for showing help message

### Generating random news headers

The command is:
```
mix randnews generate [options]
```

It has a shortcut version, "g" instead of "generate".
The possible options are:
- -f or --file, for a custom path for the file to take news headers from. By default it is "news.txt" in the current working directory
- -n or --count, for number of news headers to be generated. Default
  value: 20
- -h or --help, for showing help message

### Basic usage example

```
git clone https://github.com/olefav/randnews
cd randnews
mix deps.get
mix randnews d # for getting news headers
mix randnews g -n 50 # generate 50 new headers using data from the
previous step
```

## Testing

```
mix test
```

