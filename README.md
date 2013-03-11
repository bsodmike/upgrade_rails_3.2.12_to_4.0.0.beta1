# upgrade_rails_3.2.12_to_4.0.0.beta1

## Important!

This upgrade script is only for Rails 3.2.12 apps.  It'll work better
the newer your app is.  For more mature apps, you'll run into a lot more
conflicts as this approach involves applying a git patch.

In this case, I'd suggest [comparing your app against the generated app
diff](https://github.com/bsodmike/rails_3.2.12_vs_4.0.0.beta1/commit/acaa22105fff49e23d7d7bf642160006d3de1954).

To resolve any conflicts you can tweak the patch file in
`upgrade/upgrade.patch`.

## Usage

* In your Rails 3.2.12 app simply perform to let you know if the upgrade
applies cleanly or not.

```
bash < <(curl -L https://raw.github.com/gist/5132812)
```

* If and **only if** the above step does not report any errors, proceed
to perform

```
bash < <(curl -L https://raw.github.com/gist/5136839)
```

Your `Gemfile` and `Gemfile.lock` will be backed up into
`upgrade\backups` as seen in the source of this repo.

## License

This project rocks and uses MIT-LICENSE.
