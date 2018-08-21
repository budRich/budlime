# [Extract Sublime Pacage] - Extracts packed packages in sublime.
by: [SublimText]  

### budmod

I modified `ExtractSublimePackage.py` i added a parameter to `extract_package(filename, spcpath="")`. If `spcpath is set`, packages will get extracted to that directory instead of the default extracted package directory:

Then I added a custom directory to the `ExtractAllPackagesCommand`:  

``` py
for zippath in zippaths:
    extract_package(zippath, '/home/bud/tmp/stpkg')
_msg("Completed extracting %s packages" % zippaths_total)
```


[Extract Sublime Package]: https://github.com/SublimeText/ExtractSublimePackage
[SublimeText]: https://github.com/SublimeText
