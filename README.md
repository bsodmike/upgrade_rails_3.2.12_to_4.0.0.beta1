# upgrade_rails_3.2.12_to_4.0.0.beta1

## Important!

This upgrade script is only for Rails 3.2.12 apps.

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
