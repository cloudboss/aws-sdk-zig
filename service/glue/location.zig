const CodeGenNodeArg = @import("code_gen_node_arg.zig").CodeGenNodeArg;

/// The location of resources.
pub const Location = struct {
    /// An Amazon DynamoDB table location.
    dynamo_db: ?[]const CodeGenNodeArg = null,

    /// A JDBC location.
    jdbc: ?[]const CodeGenNodeArg = null,

    /// An Amazon Simple Storage Service (Amazon S3) location.
    s3: ?[]const CodeGenNodeArg = null,

    pub const json_field_names = .{
        .dynamo_db = "DynamoDB",
        .jdbc = "Jdbc",
        .s3 = "S3",
    };
};
