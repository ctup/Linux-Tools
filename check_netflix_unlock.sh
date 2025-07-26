#!/bin/bash

# 要测试的 Netflix 节目链接
URL="https://www.netflix.com/hk/title/80018959"

# 使用 curl 获取网页 HTML（最多重试3次）
HTML=$(curl -s --max-time 10 --retry 3 "$URL")

# 判断是否包含「無法在您的國家/地區觀賞」提示
if echo "$HTML" | grep -q "這部影片目前無法在您的國家/地區觀賞"; then
    echo "❌ 当前 IP 无法解锁 Netflix 香港（該片受限）"
    exit 1
fi

# 如果能抓到作品标题或演员信息，则可视为解锁
if echo "$HTML" | grep -q "銀魂"; then
    echo "✅ 当前 IP 已解锁 Netflix 香港，可观看《銀魂》"
    exit 0
fi

# 否则视为未知状态（可能页面结构改变或网络失败）
echo "⚠️ 无法判断当前 IP 是否解锁，请检查网络或 Netflix 页面结构是否已更改"
exit 2
