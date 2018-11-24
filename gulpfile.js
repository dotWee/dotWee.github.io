var gulp = require('gulp');
var minifyCSS = require('gulp-csso');

gulp.task('html', function () {
    return gulp.src('*.html')
        .pipe(gulp.dest('dist/'))
});

gulp.task('css', function () {
    return gulp.src(['css/*.css', 'node_modules/normalize.css/normalize.css'])
        .pipe(minifyCSS())
        .pipe(gulp.dest('dist/css/'))
});

gulp.task('js', function () {
    return gulp.src('js/*.js')
        .pipe(gulp.dest('dist/js/'))
});

gulp.task('meta', function () {
    return gulp.src(["browserconfig.xml", "favicon.ico", "humans.txt", "icon.png", "robots.txt", "site.webmanifest"])
        .pipe(gulp.dest('dist/'))
});

gulp.task('assets', function () {
    return gulp.src('assets/public.key')
        .pipe(gulp.dest('dist/assets/'))
});

gulp.task('default', ['html', 'css', 'js', 'meta', 'assets']);