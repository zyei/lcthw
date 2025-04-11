# C language

## Makefile

```makefile
# Makefile最基础结构是
# target:dependencies
# 	commands
ex1:ex1.c
	gcc -o ex1 ex1.c
```

> make会遵循一定的隐式规则，如果没有显式定义 Makefile，运行  make ex1 ， make  会尝试根据隐式规则查找是否存在  ex1.c ，并自动编译成  ex1 。

```makefile
# 稍复杂的Makefile

CFLAGS=-Wall -g        # 传递给gcc编译器参数 -Wall -g
                       # -Wall 开启所有警告（并非所有）
                       # -g 生成调试信息
                       
all:ex1                # all约定为表示构建所有内容或默认目标
ex1:ex1.c
	gcc -o ex1 ex1.c
clean:
	rm -rf ex1
```

```makefile
# Makefile参考

# 变量定义：定义编译器和编译选项
CC = gcc                # 指定编译器为 gcc
CFLAGS = -Wall -g       # 编译选项：-Wall 开启所有警告，-g 包含调试信息
LDFLAGS =               # 链接选项（这里为空，可用于添加库，如 -lm）
TARGET = myprogram      # 最终生成的可执行文件名

# 变量定义：定义源文件和目标文件
SRCS = main.c utils.c  # 源文件列表（可以有多个源文件）
OBJS = $(SRCS:.c=.o)   # 目标文件列表，通过替换 .c 为 .o 生成（main.o utils.o）

# 伪目标声明：all 和 clean 不是实际文件，而是逻辑目标
.PHONY: all clean

# 默认目标：all
# 通常是 Makefile 的第一个目标，运行 `make` 时会默认执行
# 依赖于最终的可执行文件 $(TARGET)
all: $(TARGET)
	@echo "Build completed successfully!"

# 规则：如何生成最终的可执行文件 $(TARGET)
# 依赖于目标文件 $(OBJS)
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
	# $@ 表示目标（这里是 myprogram）
	# $^ 表示所有依赖（这里是 main.o utils.o）
	# 这条命令将目标文件链接成最终的可执行文件

# 隐式规则：如何从 .c 文件生成 .o 文件
# 以下规则会自动应用于每个源文件（如 main.c -> main.o）
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<
	# $@ 表示目标（这里是某个 .o 文件）
	# $< 表示第一个依赖（这里是对应的 .c 文件）
	# -c 表示只编译不链接，生成目标文件

# 伪目标：clean
# 用于清理编译生成的文件
clean:
	rm -f $(OBJS) $(TARGET)
	@echo "Cleaned up build files."

# 伪目标：rebuild
# 先清理再重新构建
rebuild: clean all
	@echo "Rebuild completed successfully!"
```