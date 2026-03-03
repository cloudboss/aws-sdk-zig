const std = @import("std");

pub const SalesforceStandardObjectName = enum {
    account,
    campaign,
    case,
    contact,
    contract,
    document,
    group,
    idea,
    lead,
    opportunity,
    partner,
    pricebook,
    product,
    profile,
    solution,
    task,
    user,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .campaign = "CAMPAIGN",
        .case = "CASE",
        .contact = "CONTACT",
        .contract = "CONTRACT",
        .document = "DOCUMENT",
        .group = "GROUP",
        .idea = "IDEA",
        .lead = "LEAD",
        .opportunity = "OPPORTUNITY",
        .partner = "PARTNER",
        .pricebook = "PRICEBOOK",
        .product = "PRODUCT",
        .profile = "PROFILE",
        .solution = "SOLUTION",
        .task = "TASK",
        .user = "USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .campaign => "CAMPAIGN",
            .case => "CASE",
            .contact => "CONTACT",
            .contract => "CONTRACT",
            .document => "DOCUMENT",
            .group => "GROUP",
            .idea => "IDEA",
            .lead => "LEAD",
            .opportunity => "OPPORTUNITY",
            .partner => "PARTNER",
            .pricebook => "PRICEBOOK",
            .product => "PRODUCT",
            .profile => "PROFILE",
            .solution => "SOLUTION",
            .task => "TASK",
            .user => "USER",
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
