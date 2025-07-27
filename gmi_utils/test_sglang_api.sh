#!/bin/bash

echo "=== 测试SGLang API ==="
echo

BASE_URL="http://localhost:8080"

# 获取可用模型
echo "1. 获取可用模型:"
curl -s $BASE_URL/v1/models | jq . || curl -s $BASE_URL/v1/models
echo
echo

# 测试聊天完成API
echo "2. 测试聊天完成 API:"
curl -s -X POST $BASE_URL/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "default",
    "messages": [
      {
        "role": "user",
        "content": "你好，请简单介绍一下自己。"
      }
    ],
    "max_tokens": 500,
    "temperature": 0.7
  }' | jq . || curl -s -X POST $BASE_URL/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "default",
    "messages": [
      {
        "role": "user",
        "content": "你好，请简单介绍一下自己。"
      }
    ],
    "max_tokens": 500,
    "temperature": 0.7
  }'
echo
echo


# 测试健康检查
echo "4. 测试健康检查:"
curl -s $BASE_URL/health || echo "健康检查端点可能不存在"
echo
echo

# 测试服务信息
echo "5. 获取服务信息:"
curl -s $BASE_URL/get_model_info | jq . || curl -s $BASE_URL/get_model_info
echo

echo "=== 测试完成 ===" 