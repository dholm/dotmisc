###
# Configuration

# Control if GDB supports Python scripting
set $PYTHON_SUPPORT = 1

# Save GDB command history
set history save on
shell mkdir -p ~/.cache/gdb
set history filename ~/.cache/gdb/history

# Do not ask for confirmation on potentially dangerous operations
set confirm off
# Do not show information on what files symbols are being loaded from
set verbose off
# Disable pagination
set pagination off
set height 0
set width 0

# Setup good pretty printing options
set print pretty on
set print object on
set print vtbl on
set print array on
set print static-members off
set print demangle on
set print asm-demangle on

# Set radices to default
set input-radix 10
set output-radix 10

if $PYTHON_SUPPORT == 1
    # Show stack traces from Python instead of just an error message
    set python print-stack full
end


###
# Functions

define offsetof
    print (int)&((struct $arg0 *)0)->$arg1
end
document offsetof
Show the offset of MEMBER into STRUCTURE.
Usage: offsetof STRUCTURE MEMBER
end


###
# Configuration options specific to local machine. This file should never go
# into version control.
source ~/.gdbinit.local
