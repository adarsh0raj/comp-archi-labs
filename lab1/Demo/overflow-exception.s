# This example shows the overflow trap exception.
main:

#########2 cases which lead to an overflow trap#########
	# li $t1, 0x7fffffff
    # li $t2, 0x00000001

	li $t1, 0x8fffffff
    li $t2, 0x80000001

    # add $t3, $t1, $t2 

################No overflow trap since we used the addu instruction##############

    addu $t3, $t1, $t2    
    jr $ra