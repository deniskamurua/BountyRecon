#!/bin/bash
baseDir="/home/kingpin/Documents/BugBounty"


if [[ -d "$baseDir" ]]; then
    for dir in "$baseDir"/*/; do
        if [[ -f "${dir}/roots.txt" ]]; then
            programName=$(basename "$dir")
            echo "Started Recon for $programName:"
            subfinder -dL "${dir}/roots.txt" -silent  | dnsx -silent | anew -q "${dir}/resolveddomains.txt"
            httpx -l  "${dir}/resolveddomains.txt" -t 75 -silent | anew "${dir}/webservers.txt" 
            smap -iL "${dir}/resolveddomains.txt" | anew "${dir}/openports.txt"
        else 
            programName=$(basename "$dir")
            echo "No Root Domains Found for $programName!"
        fi
    done 
else
    echo "Directory '$baseDir' does not exist."
fi
