const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// The action to deliver incoming emails to an Amazon Q Business application
/// for indexing.
pub const DeliverToQBusinessAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the specified application
    /// has been deleted or the role lacks necessary permissions to call the
    /// `qbusiness:BatchPutDocument` API.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The unique identifier of the Amazon Q Business application instance where
    /// the email content will be delivered.
    application_id: []const u8,

    /// The identifier of the knowledge base index within the Amazon Q Business
    /// application where the email content will be stored and indexed.
    index_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM Role to use while delivering to
    /// Amazon Q Business. This role must have access to the
    /// `qbusiness:BatchPutDocument` API for the given application and index.
    role_arn: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .application_id = "ApplicationId",
        .index_id = "IndexId",
        .role_arn = "RoleArn",
    };
};
