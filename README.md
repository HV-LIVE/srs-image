# 基于以下开源项目

- [srs](https://github.com/ossrs/srs)

# 功能

- RTMP 协议直播推流与播放
- HLS 协议直播
- DASH 协议直播

# 部署

- 端口映射

  - RTMP 端口: 用于 RTMP 协议推流与播放。容器端口为 `11935`
  - API 端口: 用于访问 API 接口。容器端口为 `11985`
  - HTTP 端口: 用于 HLS/DASH 协议的直播以及提供其它静态资源。容器端口为 `18080`

- 高级配置

  - [配置列表](#配置列表)
  - 通过环境变量控制，启动容器时可以通过 `-e` 指定

- 部署命令

  ```bash
  docker run -d --restart=always --name srs \
          -p 11935:11935 -p 11985:11985 -p 18080:18080 \
          hvlive/srs:latest
  ```

# 直播

## RTMP 直播推流与播放

- 推流与播放地址

  - 完整地址为 `rtmp://{server-ip}:11935/live/{name}`，文档中用 `{rtmp_full_url}` 表示
  - 多个客户端同时推流时，`{name}` **不能重复**
  - 请留意 `{name}` 在后续使用 `HLS/DASH` 播放时也会用到

- OBS 推流配置

  - 服务器: `rtmp://{ip}:11935/live`
  - 串流密钥: `{name}`

- FFmpeg 推流命令

  ```bash
  # 推流本地视频文件
  ffmpeg -stream_loop -1 -re -i "{本地视频路径}" -c:v copy -c:a copy -f flv {rtmp_full_url}
  ```

- FFmpeg 播放命令

  ```bash
  ffplay -fflags nobuffer {rtmp_full_url}
  ```

- VLC 及其它播放器使用 `{rtmp_full_url}` 进行播放

## HLS 直播

- 播放地址
  - 完整地址为 `http://{server-ip}:18080/live/{name}.m3u8`
  - `{name}` 同 [RTMP 直播推流与播放](#rtmp-直播推流与播放) 中的 `{name}`

## DASH 直播

- 播放地址
  - 完整地址为 `http://{server-ip}:18080/live/{name}.mpd`
  - `{name}` 同 [RTMP 直播推流与播放](#rtmp-直播推流与播放) 中的 `{name}`

## 查看统计

- 统计地址为 `http://{server-ip}:18080/console/ng_index.html#/summaries?port=11985`
- 默认账号为 `admin`
- 默认密码为 `kGT1ypLN`

# 配置列表

| 环境变量         | 默认值   | 说明               |
| ---------------- | -------- | ------------------ |
| HV_RTMP_PORT     | 11935    | 直播 RTMP 端口     |
| HV_API_PORT      | 11985    | API 端口           |
| HV_API_USERNAME  | admin    | API 账号           |
| HV_API_PASSWORD  | kGT1ypLN | API 密码           |
| HV_HTTP_PORT     | 18080    | HTTP 端口          |
| HV_HLS_FRAGMENT  | 2        | HLS 分片的长度     |
| HV_HLS_WINDOW    | 10       | HLS 播放列表的长度 |
| HV_DASH_FRAGMENT | 2        | DASH 分片的长度    |
