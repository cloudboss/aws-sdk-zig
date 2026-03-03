const std = @import("std");

pub const OperationType = enum {
    register_domain,
    delete_domain,
    transfer_in_domain,
    update_domain_contact,
    update_nameserver,
    change_privacy_protection,
    domain_lock,
    enable_autorenew,
    disable_autorenew,
    add_dnssec,
    remove_dnssec,
    expire_domain,
    transfer_out_domain,
    change_domain_owner,
    renew_domain,
    push_domain,
    internal_transfer_out_domain,
    internal_transfer_in_domain,
    release_to_gandi,
    transfer_on_renew,
    restore_domain,

    pub const json_field_names = .{
        .register_domain = "REGISTER_DOMAIN",
        .delete_domain = "DELETE_DOMAIN",
        .transfer_in_domain = "TRANSFER_IN_DOMAIN",
        .update_domain_contact = "UPDATE_DOMAIN_CONTACT",
        .update_nameserver = "UPDATE_NAMESERVER",
        .change_privacy_protection = "CHANGE_PRIVACY_PROTECTION",
        .domain_lock = "DOMAIN_LOCK",
        .enable_autorenew = "ENABLE_AUTORENEW",
        .disable_autorenew = "DISABLE_AUTORENEW",
        .add_dnssec = "ADD_DNSSEC",
        .remove_dnssec = "REMOVE_DNSSEC",
        .expire_domain = "EXPIRE_DOMAIN",
        .transfer_out_domain = "TRANSFER_OUT_DOMAIN",
        .change_domain_owner = "CHANGE_DOMAIN_OWNER",
        .renew_domain = "RENEW_DOMAIN",
        .push_domain = "PUSH_DOMAIN",
        .internal_transfer_out_domain = "INTERNAL_TRANSFER_OUT_DOMAIN",
        .internal_transfer_in_domain = "INTERNAL_TRANSFER_IN_DOMAIN",
        .release_to_gandi = "RELEASE_TO_GANDI",
        .transfer_on_renew = "TRANSFER_ON_RENEW",
        .restore_domain = "RESTORE_DOMAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .register_domain => "REGISTER_DOMAIN",
            .delete_domain => "DELETE_DOMAIN",
            .transfer_in_domain => "TRANSFER_IN_DOMAIN",
            .update_domain_contact => "UPDATE_DOMAIN_CONTACT",
            .update_nameserver => "UPDATE_NAMESERVER",
            .change_privacy_protection => "CHANGE_PRIVACY_PROTECTION",
            .domain_lock => "DOMAIN_LOCK",
            .enable_autorenew => "ENABLE_AUTORENEW",
            .disable_autorenew => "DISABLE_AUTORENEW",
            .add_dnssec => "ADD_DNSSEC",
            .remove_dnssec => "REMOVE_DNSSEC",
            .expire_domain => "EXPIRE_DOMAIN",
            .transfer_out_domain => "TRANSFER_OUT_DOMAIN",
            .change_domain_owner => "CHANGE_DOMAIN_OWNER",
            .renew_domain => "RENEW_DOMAIN",
            .push_domain => "PUSH_DOMAIN",
            .internal_transfer_out_domain => "INTERNAL_TRANSFER_OUT_DOMAIN",
            .internal_transfer_in_domain => "INTERNAL_TRANSFER_IN_DOMAIN",
            .release_to_gandi => "RELEASE_TO_GANDI",
            .transfer_on_renew => "TRANSFER_ON_RENEW",
            .restore_domain => "RESTORE_DOMAIN",
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
