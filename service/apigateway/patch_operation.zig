const Op = @import("op.zig").Op;

/// For more information about supported patch operations, see [Patch
/// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
pub const PatchOperation = struct {
    /// The copy update operation's source as identified by a JSON-Pointer value
    /// referencing
    /// the location within the targeted resource to copy the value from. For
    /// example, to
    /// promote a canary deployment, you copy the canary deployment ID to the
    /// affiliated
    /// deployment ID by calling a PATCH request on a Stage resource with
    /// "op":"copy",
    /// "from":"/canarySettings/deploymentId" and "path":"/deploymentId".
    from: ?[]const u8,

    /// An update operation to be performed with this PATCH request. The valid value
    /// can be
    /// add, remove, replace or copy. Not all valid operations are supported for a
    /// given
    /// resource. Support of the operations depends on specific operational
    /// contexts. Attempts
    /// to apply an unsupported operation on a resource will return an error
    /// message..
    op: ?Op,

    /// The op operation's target, as identified by a JSON Pointer value that
    /// references a
    /// location within the targeted resource. For example, if the target resource
    /// has an
    /// updateable property of {"name":"value"}, the path for this property is
    /// /name. If the
    /// name property value is a JSON object (e.g., {"name": {"child/name":
    /// "child-value"}}),
    /// the path for the child/name property will be /name/child~1name. Any slash
    /// ("/")
    /// character appearing in path names must be escaped with "~1", as shown in the
    /// example
    /// above. Each op operation can have only one path associated with it.
    path: ?[]const u8,

    /// The new target value of the update operation. It is applicable for the add
    /// or replace
    /// operation. When using AWS CLI to update a property of a JSON value, enclose
    /// the JSON
    /// object with a pair of single quotes in a Linux shell, e.g., '{"a": ...}'.
    value: ?[]const u8,

    pub const json_field_names = .{
        .from = "from",
        .op = "op",
        .path = "path",
        .value = "value",
    };
};
