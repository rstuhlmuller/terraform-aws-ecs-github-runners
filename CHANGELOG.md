# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0](https://github.com/rstuhlmuller/terraform-aws-ecs-github-runners/compare/v1.0.5...v1.1.0) (2024-03-06)


### Features

* Dynamic cpu and memory vars ([#14](https://github.com/rstuhlmuller/terraform-aws-ecs-github-runners/issues/14)) ([5755b6d](https://github.com/rstuhlmuller/terraform-aws-ecs-github-runners/commit/5755b6d9d96a1fcb04fea76cb07109d433875397))

### [1.0.5](https://github.com/rstuhlmuller/aws-ecs-github-runners/compare/v1.0.4...v1.0.5) (2023-12-16)


### Bug Fixes

* ability to make null ([ad2f4b7](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/ad2f4b7bb9a7f527be4fea2a0e3a8717110550f3))
* packages ([9e003ec](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/9e003ecd2a53380f4e1aad11cea29f476be8cf58))

### [1.0.4](https://github.com/rstuhlmuller/aws-ecs-github-runners/compare/v1.0.3...v1.0.4) (2023-12-09)


### Bug Fixes

* ability to add custom role name ([c2f9f6e](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/c2f9f6e300e25352921f8f712cbae09afbabb7f8))

### [1.0.3](https://github.com/rstuhlmuller/aws-ecs-github-runners/compare/v1.0.2...v1.0.3) (2023-12-08)


### Bug Fixes

* Default values ([#11](https://github.com/rstuhlmuller/aws-ecs-github-runners/issues/11)) ([3679ecb](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/3679ecb1b1353f894941a4535ba64049f138c113))
* Missing default ([#12](https://github.com/rstuhlmuller/aws-ecs-github-runners/issues/12)) ([4c11ea3](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/4c11ea34479dcbb678c4079a4165cc8b053e7b95))
* Remove tags for this resource ([#13](https://github.com/rstuhlmuller/aws-ecs-github-runners/issues/13)) ([085f002](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/085f0024cf2ea887d3effcc8003cd4a5b8636a41))
* Tags and alarms ([#10](https://github.com/rstuhlmuller/aws-ecs-github-runners/issues/10)) ([bbea9f2](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/bbea9f2963f7fea873401ed571da40d346d3191b))

### [1.0.2](https://github.com/rstuhlmuller/aws-ecs-github-runners/compare/v1.0.1...v1.0.2) (2023-12-08)


### Bug Fixes

* Install docker by default ([295ec0e](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/295ec0ede58752ce7255355bf766e643e39bd9ca))

### [1.0.1](https://github.com/rstuhlmuller/aws-ecs-github-runners/compare/v1.0.0...v1.0.1) (2023-12-08)

## 1.0.0 (2023-12-08)


### Features

* add sudo to image ([b8d3663](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/b8d36636aa434b5218fcd7e2af1d15ef9a302fac))
* auto scaling ([7fcf198](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/7fcf198f8e9884bc34d851dd4cab7284fd533039))
* autoscaling custom ([54561a2](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/54561a2493a41926c9d0f4aad98ebb5d5e22f9ef))
* changes ([d03b77e](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/d03b77efc7494195aa838c373214298c500e382f))
* defualts ([a39dea5](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/a39dea5ace64b7335cb7e62cc4cc3c25eb9b1fd5))
* dynamic runners ([3035ad3](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/3035ad3eefe3223eebf7cb91165c01ecc86ee778))
* max and min thresholds ([382a1fb](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/382a1fb219e9aed89c54562b2ff4be37b03a59b7))
* runner_group ([60524ea](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/60524ea1195a52ab44d3a2228b826b1d33f7ef87))
* use org runners instead ([8fb8d19](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/8fb8d1983b2c8717cbfbf8f788a9e1a205b69c3f))


### Bug Fixes

* add runner group var ([aaeceeb](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/aaeceebf28a8bccbc78fb3c808aac6e95fa8311e))
* default ([dadb5e9](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/dadb5e98af59de5ad7bc05b8540be3b1648ed749))
* default ([af15d74](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/af15d74d90a5f5f48d66e254a1739854af3d4b1f))
* default blank ([8e80830](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/8e808300946d8f06d959cc7597d0a0e59565d38a))
* docker user ([cc81be9](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/cc81be903db6c487b6503c629390a22f779cf5b0))
* each key ([298e7df](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/298e7dff025276503bc191b1e2ba683411fe5175))
* family ([70458fd](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/70458fd13c2f7e81338c7a0037da29f1ccd2d2c3))
* for_each ([0bb578e](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/0bb578e22913c1e0efc4d7906bedd8add95dd24b))
* map vars ([1e77759](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/1e77759605fa9e4a4b3a67ff0bc041de67411cab))
* name ([0371662](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/03716623e7e29864ee6a66529e3dcf7e6f1014ba))
* name ([ec95897](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/ec958973d4c4350c78a2015403edbdc6d5c8f0dd))
* naming prefix ([e8ee058](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/e8ee0583fbd962207f7f94dbdec825abd8a91a16))
* null ([58989dc](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/58989dc504e0faaa1206214869fcb3fd3a6609a2))
* null runner group ([4b285ad](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/4b285adac63b31b7d23e36fbf3401c0d4a6a131e))
* optional params ([bd2f30a](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/bd2f30a5d91e887137cb0eb0fbbc8ec0c1681525))
* override ([361518f](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/361518f9a98f00226fdefa14f3226d1f152a0c4b))
* runnergroup ([8119b66](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/8119b66a1c7cd1494514a7bf42f43a7ae307a212))
* scaling name prefix ([4b8e14c](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/4b8e14cb5b9e060358337b20de756b08bc52b3f1))
* secret arn regex ([111fd9a](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/111fd9aef75bb01fced617d409e808cb5be55e83))
* task name ([bc1545e](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/bc1545e3e2028c405b7055523cf9dc555fc709ae))
* token override ([6200cef](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/6200cef9e121484f0ed7934d5e4acfa3770b599f))
* use root user ([2a06f16](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/2a06f167d2c171391e5248f72cc53bf4dd3b23c1))
* var ([024e8c1](https://github.com/rstuhlmuller/aws-ecs-github-runners/commit/024e8c1c34867f50493bead3bceb740218c2195b))
