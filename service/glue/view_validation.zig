const ViewDialect = @import("view_dialect.zig").ViewDialect;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ResourceState = @import("resource_state.zig").ResourceState;

/// A structure that contains information for an analytical engine to validate a
/// view, prior to persisting the view metadata. Used in the case of direct
/// `UpdateTable` or `CreateTable` API calls.
pub const ViewValidation = struct {
    /// The dialect of the query engine.
    dialect: ?ViewDialect,

    /// The version of the dialect of the query engine. For example, 3.0.0.
    dialect_version: ?[]const u8,

    /// An error associated with the validation.
    @"error": ?ErrorDetail,

    /// The state of the validation.
    state: ?ResourceState,

    /// The time of the last update.
    update_time: ?i64,

    /// The `SELECT` query that defines the view, as provided by the customer.
    view_validation_text: ?[]const u8,

    pub const json_field_names = .{
        .dialect = "Dialect",
        .dialect_version = "DialectVersion",
        .@"error" = "Error",
        .state = "State",
        .update_time = "UpdateTime",
        .view_validation_text = "ViewValidationText",
    };
};
