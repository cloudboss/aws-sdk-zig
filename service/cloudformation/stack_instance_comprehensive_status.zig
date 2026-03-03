const StackInstanceDetailedStatus = @import("stack_instance_detailed_status.zig").StackInstanceDetailedStatus;

/// The detailed status of the stack instance.
pub const StackInstanceComprehensiveStatus = struct {
    /// * `CANCELLED`: The operation in the specified account and Region has been
    /// canceled. This is either because a user has stopped the StackSet operation,
    /// or because the
    /// failure tolerance of the StackSet operation has been exceeded.
    ///
    /// * `FAILED`: The operation in the specified account and Region failed. If the
    /// StackSet operation fails in enough accounts within a Region, the failure
    /// tolerance for the
    /// StackSet operation as a whole might be exceeded.
    ///
    /// * `FAILED_IMPORT`: The import of the stack instance in the specified account
    ///   and
    /// Region failed and left the stack in an unstable state. Once the issues
    /// causing the failure are
    /// fixed, the import operation can be retried. If enough StackSet operations
    /// fail in enough
    /// accounts within a Region, the failure tolerance for the StackSet operation
    /// as a whole might be
    /// exceeded.
    ///
    /// * `INOPERABLE`: A `DeleteStackInstances` operation has failed and left
    /// the stack in an unstable state. Stacks in this state are excluded from
    /// further
    /// `UpdateStackSet` operations. You might need to perform a
    /// `DeleteStackInstances` operation, with `RetainStacks` set to
    /// `true`, to delete the stack instance, and then delete the stack manually.
    ///
    /// * `PENDING`: The operation in the specified account and Region has yet to
    /// start.
    ///
    /// * `RUNNING`: The operation in the specified account and Region is currently
    ///   in
    /// progress.
    ///
    /// * `SKIPPED_SUSPENDED_ACCOUNT`: The operation in the specified account and
    ///   Region
    /// has been skipped because the account was suspended at the time of the
    /// operation.
    ///
    /// * `SUCCEEDED`: The operation in the specified account and Region completed
    /// successfully.
    detailed_status: ?StackInstanceDetailedStatus = null,
};
