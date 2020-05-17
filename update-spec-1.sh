#!/bin/bash

ls spec-1-parts/*.md | sort | xargs cat >spec-1.md
