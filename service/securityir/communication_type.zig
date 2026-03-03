const std = @import("std");

pub const CommunicationType = enum {
    case_created,
    case_updated,
    case_acknowledged,
    case_closed,
    case_updated_to_service_managed,
    case_update_case_status,
    case_pending_customer_action_reminder,
    case_attachment_url_uploaded,
    case_comment_added,
    case_comment_updated,
    membership_created,
    membership_updated,
    membership_cancelled,
    register_delegated_administrator,
    deregister_delegated_administrator,
    disable_aws_service_access,

    pub const json_field_names = .{
        .case_created = "Case Created",
        .case_updated = "Case Updated",
        .case_acknowledged = "Case Acknowledged",
        .case_closed = "Case Closed",
        .case_updated_to_service_managed = "Case Updated To Service Managed",
        .case_update_case_status = "Case Status Updated",
        .case_pending_customer_action_reminder = "Case Pending Customer Action Reminder",
        .case_attachment_url_uploaded = "Case Attachment Url Uploaded",
        .case_comment_added = "Case Comment Added",
        .case_comment_updated = "Case Comment Updated",
        .membership_created = "Membership Created",
        .membership_updated = "Membership Updated",
        .membership_cancelled = "Membership Cancelled",
        .register_delegated_administrator = "Register Delegated Administrator",
        .deregister_delegated_administrator = "Deregister Delegated Administrator",
        .disable_aws_service_access = "Disable AWS Service Access",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .case_created => "Case Created",
            .case_updated => "Case Updated",
            .case_acknowledged => "Case Acknowledged",
            .case_closed => "Case Closed",
            .case_updated_to_service_managed => "Case Updated To Service Managed",
            .case_update_case_status => "Case Status Updated",
            .case_pending_customer_action_reminder => "Case Pending Customer Action Reminder",
            .case_attachment_url_uploaded => "Case Attachment Url Uploaded",
            .case_comment_added => "Case Comment Added",
            .case_comment_updated => "Case Comment Updated",
            .membership_created => "Membership Created",
            .membership_updated => "Membership Updated",
            .membership_cancelled => "Membership Cancelled",
            .register_delegated_administrator => "Register Delegated Administrator",
            .deregister_delegated_administrator => "Deregister Delegated Administrator",
            .disable_aws_service_access => "Disable AWS Service Access",
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
