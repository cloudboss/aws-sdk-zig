const ConflictDetectionType = @import("conflict_detection_type.zig").ConflictDetectionType;
const ConflictHandlerType = @import("conflict_handler_type.zig").ConflictHandlerType;
const LambdaConflictHandlerConfig = @import("lambda_conflict_handler_config.zig").LambdaConflictHandlerConfig;

/// Describes a Sync configuration for a resolver.
///
/// Specifies which Conflict Detection strategy and Resolution strategy to use
/// when the
/// resolver is invoked.
pub const SyncConfig = struct {
    /// The Conflict Detection strategy to use.
    ///
    /// * **VERSION**: Detect conflicts based on object
    /// versions for this resolver.
    ///
    /// * **NONE**: Do not detect conflicts when invoking
    /// this resolver.
    conflict_detection: ?ConflictDetectionType,

    /// The Conflict Resolution strategy to perform in the event of a conflict.
    ///
    /// * **OPTIMISTIC_CONCURRENCY**: Resolve conflicts by
    /// rejecting mutations when versions don't match the latest version at the
    /// server.
    ///
    /// * **AUTOMERGE**: Resolve conflicts with the
    /// Automerge conflict resolution strategy.
    ///
    /// * **LAMBDA**: Resolve conflicts with an Lambda function supplied in the
    /// `LambdaConflictHandlerConfig`.
    conflict_handler: ?ConflictHandlerType,

    /// The `LambdaConflictHandlerConfig` when configuring `LAMBDA` as the
    /// Conflict Handler.
    lambda_conflict_handler_config: ?LambdaConflictHandlerConfig,

    pub const json_field_names = .{
        .conflict_detection = "conflictDetection",
        .conflict_handler = "conflictHandler",
        .lambda_conflict_handler_config = "lambdaConflictHandlerConfig",
    };
};
