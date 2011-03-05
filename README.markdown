Stupa client library for Ruby
=============================

A Ruby client for [Stupa](http://code.google.com/p/stupa/).

"Stupa is an associative search engine.
You can search related documents with high performance and high precision.
Since document data and inverted indexes are kept in memory,
Stupa reflects updates of documents in search results in real time."

The current SVN code of Stupa contains a fast HTTP API built on libevent.
This is what this library connects to.

Usage
=====

    require 'stupa'

    client = Stupa::Client.new(host: "localhost", port: 22122)

    # delete all entries
    client.clear

    # get the number of entries in the database
    size = client.size

    # record a couple key/features tuples
    client.add('key1' => 'feat1')
    client.add('key2' => 'feat2', 'key3' => 'feat3')
    client.add('key4' => ['feat4', 'feat5', 'feat6'])

    # delete keys
    client.delete('key3')
    client.delete(['key1', 'key2'])

    # dump the database
    client.save('/var/db/stupa.db')

    # load from a dump
    client.load('/var/db/stupa.db')

    # look for entries similar to key1
    results = client.dsearch(query: 'key1')
    results = client.dsearch(query: 'key1', max: 50)

    # look for keys with matching features
    results = client.fsearch(query: 'feat1')
    results = client.fsearch(query: ['feat2', 'feat3'])
    results = client.fsearch(query: ['feat2', 'feat3'], max: 50)

Copyright
=========

See LICENSE for details.
