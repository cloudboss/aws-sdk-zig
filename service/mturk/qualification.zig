const Locale = @import("locale.zig").Locale;
const QualificationStatus = @import("qualification_status.zig").QualificationStatus;

/// The Qualification data structure represents a Qualification
/// assigned to a user, including the Qualification type and the value
/// (score).
pub const Qualification = struct {
    /// The date and time the Qualification was granted to the
    /// Worker. If the Worker's Qualification was revoked, and then
    /// re-granted based on a new Qualification request, GrantTime is the
    /// date and time of the last call to the AcceptQualificationRequest
    /// operation.
    grant_time: ?i64,

    /// The value (score) of the Qualification, if the Qualification
    /// has an integer value.
    integer_value: ?i32,

    locale_value: ?Locale,

    /// The ID of the Qualification type for the Qualification.
    qualification_type_id: ?[]const u8,

    /// The status of the Qualification. Valid values are Granted |
    /// Revoked.
    status: ?QualificationStatus,

    /// The ID of the Worker who possesses the Qualification.
    worker_id: ?[]const u8,

    pub const json_field_names = .{
        .grant_time = "GrantTime",
        .integer_value = "IntegerValue",
        .locale_value = "LocaleValue",
        .qualification_type_id = "QualificationTypeId",
        .status = "Status",
        .worker_id = "WorkerId",
    };
};
