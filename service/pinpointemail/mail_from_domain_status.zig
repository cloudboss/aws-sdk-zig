const std = @import("std");

/// The status of the MAIL FROM domain. This status can have the following
/// values:
///
/// * `PENDING` – Amazon Pinpoint hasn't started searching for the MX record
/// yet.
///
/// * `SUCCESS` – Amazon Pinpoint detected the required MX record for the
/// MAIL FROM domain.
///
/// * `FAILED` – Amazon Pinpoint can't find the required MX record, or the
/// record no longer exists.
///
/// * `TEMPORARY_FAILURE` – A temporary issue occurred, which
/// prevented Amazon Pinpoint from determining the status of the MAIL FROM
/// domain.
pub const MailFromDomainStatus = enum {
    pending,
    success,
    failed,
    temporary_failure,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .temporary_failure = "TEMPORARY_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .success => "SUCCESS",
            .failed => "FAILED",
            .temporary_failure => "TEMPORARY_FAILURE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
