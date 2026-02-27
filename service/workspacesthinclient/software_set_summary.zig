const SoftwareSetValidationStatus = @import("software_set_validation_status.zig").SoftwareSetValidationStatus;

/// Describes a software set.
pub const SoftwareSetSummary = struct {
    /// The Amazon Resource Name (ARN) of the software set.
    arn: ?[]const u8,

    /// The ID of the software set.
    id: ?[]const u8,

    /// The timestamp of when the software set was released.
    released_at: ?i64,

    /// The timestamp of the end of support for the software set.
    supported_until: ?i64,

    /// An option to define if the software set has been validated.
    validation_status: ?SoftwareSetValidationStatus,

    /// The version of the software set.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .released_at = "releasedAt",
        .supported_until = "supportedUntil",
        .validation_status = "validationStatus",
        .version = "version",
    };
};
