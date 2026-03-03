const std = @import("std");

pub const ApprovalTeamStatusCode = enum {
    validating,
    pending_activation,
    failed_validation,
    failed_activation,
    update_pending_approval,
    update_pending_activation,
    update_failed_approval,
    update_failed_activation,
    update_failed_validation,
    delete_pending_approval,
    delete_failed_approval,
    delete_failed_validation,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .pending_activation = "PENDING_ACTIVATION",
        .failed_validation = "FAILED_VALIDATION",
        .failed_activation = "FAILED_ACTIVATION",
        .update_pending_approval = "UPDATE_PENDING_APPROVAL",
        .update_pending_activation = "UPDATE_PENDING_ACTIVATION",
        .update_failed_approval = "UPDATE_FAILED_APPROVAL",
        .update_failed_activation = "UPDATE_FAILED_ACTIVATION",
        .update_failed_validation = "UPDATE_FAILED_VALIDATION",
        .delete_pending_approval = "DELETE_PENDING_APPROVAL",
        .delete_failed_approval = "DELETE_FAILED_APPROVAL",
        .delete_failed_validation = "DELETE_FAILED_VALIDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validating => "VALIDATING",
            .pending_activation => "PENDING_ACTIVATION",
            .failed_validation => "FAILED_VALIDATION",
            .failed_activation => "FAILED_ACTIVATION",
            .update_pending_approval => "UPDATE_PENDING_APPROVAL",
            .update_pending_activation => "UPDATE_PENDING_ACTIVATION",
            .update_failed_approval => "UPDATE_FAILED_APPROVAL",
            .update_failed_activation => "UPDATE_FAILED_ACTIVATION",
            .update_failed_validation => "UPDATE_FAILED_VALIDATION",
            .delete_pending_approval => "DELETE_PENDING_APPROVAL",
            .delete_failed_approval => "DELETE_FAILED_APPROVAL",
            .delete_failed_validation => "DELETE_FAILED_VALIDATION",
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
