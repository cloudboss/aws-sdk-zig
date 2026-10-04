const std = @import("std");

/// The following log types are supported for log delivery configuration:
///
/// * APPLICATION_LOGS – Application-level logs.
/// * USAGE_LOGS – Resource usage logs.
/// * SECURITY_FINDING_LOGS – Security finding logs.
/// * ACCESS_LOGS – Access logs (such as Elastic Load Balancing access logs).
/// * CONNECTION_LOGS – Connection logs.
/// * S3_SERVER_ACCESS_LOGS – Amazon S3 server access logs.
pub const LogType = enum {
    application,
    usage,
    security_finding,
    access,
    connection,
    s3_server_access,
    alb_access,
    alb_connection,
    alb_health_check,

    pub const json_field_names = .{
        .application = "APPLICATION_LOGS",
        .usage = "USAGE_LOGS",
        .security_finding = "SECURITY_FINDING_LOGS",
        .access = "ACCESS_LOGS",
        .connection = "CONNECTION_LOGS",
        .s3_server_access = "S3_SERVER_ACCESS_LOGS",
        .alb_access = "ALB_ACCESS_LOGS",
        .alb_connection = "ALB_CONNECTION_LOGS",
        .alb_health_check = "ALB_HEALTH_CHECK_LOGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application => "APPLICATION_LOGS",
            .usage => "USAGE_LOGS",
            .security_finding => "SECURITY_FINDING_LOGS",
            .access => "ACCESS_LOGS",
            .connection => "CONNECTION_LOGS",
            .s3_server_access => "S3_SERVER_ACCESS_LOGS",
            .alb_access => "ALB_ACCESS_LOGS",
            .alb_connection => "ALB_CONNECTION_LOGS",
            .alb_health_check => "ALB_HEALTH_CHECK_LOGS",
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
