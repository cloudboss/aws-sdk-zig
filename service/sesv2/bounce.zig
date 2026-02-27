const BounceType = @import("bounce_type.zig").BounceType;

/// Information about a `Bounce` event.
pub const Bounce = struct {
    /// The subtype of the bounce, as determined by SES.
    bounce_sub_type: ?[]const u8,

    /// The type of the bounce, as determined by SES.
    /// Can be one of `UNDETERMINED`, `TRANSIENT`, or `PERMANENT`
    bounce_type: ?BounceType,

    /// The status code issued by the reporting Message Transfer Authority (MTA).
    /// This field only appears if a delivery status notification (DSN) was attached
    /// to the bounce
    /// and the `Diagnostic-Code` was provided in the DSN.
    diagnostic_code: ?[]const u8,

    pub const json_field_names = .{
        .bounce_sub_type = "BounceSubType",
        .bounce_type = "BounceType",
        .diagnostic_code = "DiagnosticCode",
    };
};
