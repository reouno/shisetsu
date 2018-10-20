# shisetsu

### test env

- elm 0.18.0
- node v6.13.1
- npm 3.10.10 # may not need
- yarn 1.5.1

### install

1. clone this repository

    ```
    git clone https://github.com/reouno/shisetsu.git
    ```

2. go to the directory

    ```
    cd shisetsu
    ```

3. copy mock database to project root directory

    ```
    # under [shisetsu directory]
    cp mock_data/db.json ./
    ```

4. install packages

    ```
    # install node modules with yarn or npm
    yarn install # npm install

    # install elm packages
    elm-package install -y
    ```
5. run with development environment

    ```
    yarn start
    ```
6. access to [http://localhost:3000](http://localhost:3000)

## LICENSE

This software is released under MIT License, see [LICENSE](https://github.com/reouno/shisetsu/blob/add-license-1/LICENSE).
