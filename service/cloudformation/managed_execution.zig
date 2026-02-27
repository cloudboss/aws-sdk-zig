/// Describes whether StackSets performs non-conflicting operations concurrently
/// and queues
/// conflicting operations.
pub const ManagedExecution = struct {
    /// When `true`, CloudFormation performs non-conflicting operations concurrently
    /// and
    /// queues conflicting operations. After conflicting operations finish,
    /// CloudFormation starts queued
    /// operations in request order.
    ///
    /// If there are already running or queued operations, CloudFormation queues all
    /// incoming
    /// operations even if they are non-conflicting.
    ///
    /// You can't modify your StackSet's execution configuration while there are
    /// running or queued
    /// operations for that StackSet.
    ///
    /// When `false` (default), StackSets performs one operation at a time in
    /// request
    /// order.
    active: ?bool,
};
