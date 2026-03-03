const std = @import("std");

pub const ApplicationPermission = enum {
    create_dataset,
    manage_clusters,
    manage_users_and_groups,
    manage_attribute_sets,
    view_audit_data,
    access_notebooks,
    get_temporary_credentials,

    pub const json_field_names = .{
        .create_dataset = "CreateDataset",
        .manage_clusters = "ManageClusters",
        .manage_users_and_groups = "ManageUsersAndGroups",
        .manage_attribute_sets = "ManageAttributeSets",
        .view_audit_data = "ViewAuditData",
        .access_notebooks = "AccessNotebooks",
        .get_temporary_credentials = "GetTemporaryCredentials",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_dataset => "CreateDataset",
            .manage_clusters => "ManageClusters",
            .manage_users_and_groups => "ManageUsersAndGroups",
            .manage_attribute_sets => "ManageAttributeSets",
            .view_audit_data => "ViewAuditData",
            .access_notebooks => "AccessNotebooks",
            .get_temporary_credentials => "GetTemporaryCredentials",
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
