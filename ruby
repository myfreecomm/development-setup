echo "Installing Ruby 1.9.2 stable and making it the default Ruby ..."
	curl https://raw.github.com/gist/1008945/7532898172cd9f03b4c0d0db145bc2440dcbb2f6/load.patch > load.patch
	curl https://raw.github.com/gist/856296/a19ac26fe7412ef398bd9f57e61f06fef1f186fe/patch-1.9.2-gc.patch > gc.patch
	rvm install 1.9.2-p180 --patch load.patch,gc.patch -n loadgc
	rm gc.patch load.patch
  rvm use ruby-1.9.2-p180-loadgc --default
	mkdir -p ~/.rvm/hooks
	cat <<EOF > ~/.rvm/hooks/after_use
	case "\$rvm_ruby_string" in
*ree*|*loadgc*)
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
export RUBY_FREE_MIN=$RUBY_HEAP_FREE_MIN
;;
*)
unset RUBY_HEAP_MIN_SLOTS RUBY_HEAP_SLOTS_INCREMENT RUBY_HEAP_SLOTS_GROWTH_FACTOR RUBY_GC_MALLOC_LIMIT RUBY_HEAP_FREE_MIN RUBY_FREE_MIN
;;
esac
EOF

echo "Installing Bundler for managing Ruby libraries ..."
  gem install bundler --no-rdoc --no-ri