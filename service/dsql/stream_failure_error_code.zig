const std = @import("std");

/// Error codes for stream failures.
///
/// **KINESIS_THROUGHPUT_EXCEEDED**
///
/// The Kinesis stream throughput limit was exceeded.
///
/// **KINESIS_STREAM_NOT_FOUND**
///
/// The specified Kinesis stream was not found.
///
/// **ROLE_ACCESS_DENIED**
///
/// Access was denied for the specified IAM role.
///
/// **KINESIS_ACCESS_DENIED**
///
/// Access to the Kinesis stream was denied.
///
/// **KINESIS_KMS_ACCESS_DENIED**
///
/// Access to the KMS key for the Kinesis stream was denied.
///
/// **KINESIS_OVERSIZE_RECORD**
///
/// A record exceeded the Kinesis stream size limit.
///
/// **CLUSTER_CMK_INACCESSIBLE**
///
/// The cluster's customer-managed key is inaccessible.
///
/// **INTERNAL_ERROR**
///
/// An internal error occurred.
pub const StreamFailureErrorCode = enum {
    kinesis_throughput_exceeded,
    kinesis_stream_not_found,
    role_access_denied,
    kinesis_access_denied,
    kinesis_kms_access_denied,
    kinesis_oversize_record,
    cluster_cmk_inaccessible,
    internal_error,

    pub const json_field_names = .{
        .kinesis_throughput_exceeded = "KINESIS_THROUGHPUT_EXCEEDED",
        .kinesis_stream_not_found = "KINESIS_STREAM_NOT_FOUND",
        .role_access_denied = "ROLE_ACCESS_DENIED",
        .kinesis_access_denied = "KINESIS_ACCESS_DENIED",
        .kinesis_kms_access_denied = "KINESIS_KMS_ACCESS_DENIED",
        .kinesis_oversize_record = "KINESIS_OVERSIZE_RECORD",
        .cluster_cmk_inaccessible = "CLUSTER_CMK_INACCESSIBLE",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kinesis_throughput_exceeded => "KINESIS_THROUGHPUT_EXCEEDED",
            .kinesis_stream_not_found => "KINESIS_STREAM_NOT_FOUND",
            .role_access_denied => "ROLE_ACCESS_DENIED",
            .kinesis_access_denied => "KINESIS_ACCESS_DENIED",
            .kinesis_kms_access_denied => "KINESIS_KMS_ACCESS_DENIED",
            .kinesis_oversize_record => "KINESIS_OVERSIZE_RECORD",
            .cluster_cmk_inaccessible => "CLUSTER_CMK_INACCESSIBLE",
            .internal_error => "INTERNAL_ERROR",
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
