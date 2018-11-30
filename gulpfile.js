var gulp = require('gulp');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-csso');
var sass = require('gulp-sass');
sass.compiler = require('node-sass');

var paths = {
    img: {
        src: ['./src/img/*.png', './src/img/*.jpg'],
        dest: './dist/img/'
    },
    js: {
        src: './src/js/*.js',
        dest: './dist/js/'
    },
    html: {
        src: './src/*.html',
        dest: './dist/'
    },
    css: {
        src: './src/css/*.css',
        dest: './dist/css/'
    },
    sass: {
        src: './src/sass/**/*.scss',
        dest: './dist/css/',
        opts: {}
    },
    meta: {
        src: ['src/browserconfig.xml', 'src/favicon.ico', 'src/humans.txt', 'src/icon.png', 'src/robots.txt', 'src/site.webmanifest'],
        dest: './dist/'
    }
};

gulp.task('html', function () {
    return gulp.src(paths.html.src)
        .pipe(gulp.dest(paths.html.dest))
});

gulp.task('css', function () {
    return gulp.src(paths.css.src)
        .pipe(minifyCSS())
        .pipe(gulp.dest(paths.css.dest))
});
gulp.task('sass', function () {
    return gulp.src(paths.sass.src)
        .pipe(sass().on('error', sass.logError))
        .pipe(minifyCSS())
        .pipe(gulp.dest(paths.sass.dest));
});

gulp.task('img', function () {
    return gulp.src(['src/img/*.png', 'src/img/*.jpg'])
        .pipe(gulp.dest('dist/img/'))
});

gulp.task('js', function () {
    return gulp.src(paths.js.src)
        .pipe(gulp.dest(paths.js.dest))
});

gulp.task('meta', function () {
    return gulp.src(paths.meta.src)
        .pipe(gulp.dest(paths.meta.dest))
});
gulp.task('watch', function () {
    gulp.watch(paths.sass.src, gulp.series('sass'));
    gulp.watch(paths.css.src, gulp.series('css'));
    gulp.watch(paths.html.src, gulp.series('html'));
    gulp.watch(paths.img.src, gulp.series('img'));
    gulp.watch(paths.js.src, gulp.series('js'));
    gulp.watch(paths.meta.src, gulp.series('meta'));
});

gulp.task('assets', function () {
    return gulp.src('src/assets/public.key')
        .pipe(gulp.dest('dist/assets/'))
});

gulp.task('normalize', function () {
    return gulp.src('node_modules/normalize.css/normalize.css')
        .pipe(minifyCSS())
        .pipe(gulp.dest('dist/css/'))
});

gulp.task('default', gulp.parallel('html', 'css', 'sass', 'img', 'js', 'meta', 'assets', 'normalize'));