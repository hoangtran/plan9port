.globl _tas
_tas:
	movl $0xCAFEBABE, %eax
	movl 4(%esp), %ecx
	xchgl %eax, 0(%ecx)
	ret

.globl getcontext
getcontext:
	movl	4(%esp), %eax
	addl		$16, %eax	/* point to mcontext */
	
	movl	%fs, 8(%eax)
	movl	%es, 12(%eax)
	movl	%ds, 16(%eax)
	movl	%ss, 76(%eax)
	movl	%edi, 20(%eax)
	movl	%esi, 24(%eax)
	movl	%ebp, 28(%eax)
	movl	%ebx, 36(%eax)
	movl	%edx, 40(%eax)		 
	movl	%ecx, 44(%eax)

	movl	$1, 48(%eax)	/* %eax */
	movl	(%esp), %ecx	/* %eip */
	movl	%ecx, 60(%eax)
	leal	4(%esp), %ecx	/* %esp */
	movl	%ecx, 72(%eax)
	
	movl	44(%eax), %ecx	/* restore %ecx */
	movl	$0, %eax
	ret

.globl setcontext
setcontext:
	movl	4(%esp), %eax
	addl		$16, %eax	/* point to mcontext */
	
	movl	8(%eax), %fs
	movl	12(%eax), %es
	movl	16(%eax), %ds
	movl	76(%eax), %ss
	movl	20(%eax), %edi
	movl	24(%eax), %esi
	movl	28(%eax), %ebp
	movl	36(%eax), %ebx
	movl	40(%eax), %edx
	movl	72(%eax), %esp
	
	movl	60(%eax), %ecx	/* push new %eip */
	pushl	%ecx

	movl	44(%eax), %ecx
	movl	48(%eax), %eax
	ret
