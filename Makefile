# 稍复杂的Makefile
CC = gcc               # 指定编译器为gcc
CFLAGS=-Wall -g        # 传递给gcc编译器参数 -Wall -g
                       # -Wall 开启所有警告（并非所有）
                       # -g 生成调试信息
Target=lcthw           # 最终生成可执行文件名

# 动态查找最新的源文件
ALL_SRCS = $(wildcard ex*.c)        # 使用 wildcard 获取所有 ex*.c 文件

# 使用 shell 命令找到编号最大的 ex*.c 文件
# ls ex*.c 列出所有文件，sort -Vr 按版本号逆序排序（即最大值在前），head -n 1 取第一个
LATEST_SRC = $(shell ls ex*.c | sort -Vr | head -n 1)

# 如果没有找到源文件，提示错误
ifeq ($(LATEST_SRC),)
$(error No source files matching ex*.c found!)
endif

# 默认目标
all:$(Target)
	@echo "Build $(LATEST_SRC) Success!"

# 生成最终可执行文件
$(Target):$(LATEST_SRC)
	$(CC) $(CFLAGS) -o $@ $<
# $@ 表示规则中的目标文件, $^ 表示规则中所有的依赖文件,$< 表示规则中的第一个依赖文件


clean:
	rm -f $(Target)