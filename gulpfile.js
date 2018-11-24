var gulp = require('gulp');
var minifyCSS = require('gulp-csso');

gulp.task('html', function () {
    return gulp.src('src/*.html')
        .pipe(gulp.dest('dist/'))
});

gulp.task('css', function () {
    return gulp.src(['src/css/*.css', 'node_modules/normalize.css/normalize.css'])
        .pipe(minifyCSS())
        .pipe(gulp.dest('dist/css/'))
});

gulp.task('img', function () {
    return gulp.src(['src/img/*.png', 'src/img/*.jpg'])
        .pipe(gulp.dest('dist/img/'))
});

gulp.task('js', function () {
    return gulp.src('src/js/*.js')
        .pipe(gulp.dest('dist/js/'))
});

gulp.task('meta', function () {
    return gulp.src(['src/browserconfig.xml', 'src/favicon.ico', 'src/humans.txt', 'src/icon.png', 'src/robots.txt', 'src/site.webmanifest'])
        .pipe(gulp.dest('dist/'))
});

gulp.task('assets', function () {
    return gulp.src('src/assets/public.key')
        .pipe(gulp.dest('dist/assets/'))
});

gulp.task('default', ['html', 'css', 'img', 'js', 'meta', 'assets']);