const Code = @import("code.zig").Code;
const Details = @import("details.zig").Details;
const JobErrorLimitName = @import("job_error_limit_name.zig").JobErrorLimitName;
const JobErrorResourceTypes = @import("job_error_resource_types.zig").JobErrorResourceTypes;

/// An error that occurred with the job request.
pub const JobError = struct {
    /// The code for the job error.
    code: Code,

    /// The details about the job error.
    details: ?Details,

    /// The name of the limit that was reached.
    limit_name: ?JobErrorLimitName,

    /// The value of the exceeded limit.
    limit_value: f64 = 0,

    /// The message related to the job error.
    message: []const u8,

    /// The unique identifier for the resource related to the error.
    resource_id: ?[]const u8,

    /// The type of resource related to the error.
    resource_type: ?JobErrorResourceTypes,

    pub const json_field_names = .{
        .code = "Code",
        .details = "Details",
        .limit_name = "LimitName",
        .limit_value = "LimitValue",
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
