const CodeContentType = @import("code_content_type.zig").CodeContentType;
const CodeContentUpdate = @import("code_content_update.zig").CodeContentUpdate;

/// Describes code configuration updates for an application. This is supported
/// for a Managed Service for Apache Flink application or a SQL-based Kinesis
/// Data Analytics application.
pub const ApplicationCodeConfigurationUpdate = struct {
    /// Describes updates to the code content type.
    code_content_type_update: ?CodeContentType,

    /// Describes updates to the code content of an application.
    code_content_update: ?CodeContentUpdate,

    pub const json_field_names = .{
        .code_content_type_update = "CodeContentTypeUpdate",
        .code_content_update = "CodeContentUpdate",
    };
};
