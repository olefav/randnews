# Randnews

Randnews is a made-for-fun tool for generating random news headers via [Markov chains](https://en.wikipedia.org/wiki/Markov_chain).
Current news sources include the following sources:
- [5 канал](https://www.5.ua/)
- [Цензор.НЕТ](https://censor.net.ua/ua/)
- [НВ](https://nv.ua/ukr/)
- [Українська правда](https://www.pravda.com.ua/)
- [ukr.net](https://www.ukr.net/)

## Prerequisites

In order to be able to launch the tool you need to have Elixir (tested
on 1.8.2) + OTP installed. Also get the dependencies via mix deps.get
before launching the main mix task.

## Usage

Main functions of the Randnews tool are accessible via the Mix
task with the same name. It has two main modes of operation: getting news headers and
generating new ones. Before generating random news headers it is
necessary to have a file with existing strings, any newline-separated
will be OK, Randnews has a special command for generating its own, described below.

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
- -n or --count, used for indicating how many pages do you want to be
  fetched for every news source
- -h or --help, for showing help message

### Generating random news headers

The command is:
```
mix randnews generate [options]
```

It has a shortcut version, "g" instead of "generate".
The possible options are:
- -f or --file, for a custom path for the file to take news headers from. By default it is "news.txt" in the current working directory
- -n or --count, for number of news headers to be generated
- -h or --help, for showing help message

### Basic usage example

```
git clone https://github.com/olefav/randnews
cd randnews
mix deps.get
mix randnews d
mix randnews g -n 50
```

## Testing

```
mix test
```

