const std = @import("std");

pub const CompetitorName = enum {
    oracle_cloud,
    on_prem,
    co_location,
    akamai,
    alicloud,
    google_cloud_platform,
    ibm_softlayer,
    microsoft_azure,
    other_cost_optimization,
    no_competition,
    other,

    pub const json_field_names = .{
        .oracle_cloud = "Oracle Cloud",
        .on_prem = "On-Prem",
        .co_location = "Co-location",
        .akamai = "Akamai",
        .alicloud = "AliCloud",
        .google_cloud_platform = "Google Cloud Platform",
        .ibm_softlayer = "IBM Softlayer",
        .microsoft_azure = "Microsoft Azure",
        .other_cost_optimization = "Other- Cost Optimization",
        .no_competition = "No Competition",
        .other = "*Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oracle_cloud => "Oracle Cloud",
            .on_prem => "On-Prem",
            .co_location => "Co-location",
            .akamai => "Akamai",
            .alicloud => "AliCloud",
            .google_cloud_platform => "Google Cloud Platform",
            .ibm_softlayer => "IBM Softlayer",
            .microsoft_azure => "Microsoft Azure",
            .other_cost_optimization => "Other- Cost Optimization",
            .no_competition => "No Competition",
            .other => "*Other",
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
