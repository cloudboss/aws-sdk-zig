const std = @import("std");

pub const AwsOpportunityStage = enum {
    not_started,
    in_progress,
    prospect,
    engaged,
    identified,
    qualify,
    research,
    seller_engaged,
    evaluating,
    seller_registered,
    term_sheet_negotiation,
    contract_negotiation,
    onboarding,
    building_integration,
    qualified,
    on_hold,
    technical_validation,
    business_validation,
    committed,
    launched,
    deferred_to_partner,
    closed_lost,
    completed,
    closed_incomplete,

    pub const json_field_names = .{
        .not_started = "Not Started",
        .in_progress = "In Progress",
        .prospect = "Prospect",
        .engaged = "Engaged",
        .identified = "Identified",
        .qualify = "Qualify",
        .research = "Research",
        .seller_engaged = "Seller Engaged",
        .evaluating = "Evaluating",
        .seller_registered = "Seller Registered",
        .term_sheet_negotiation = "Term Sheet Negotiation",
        .contract_negotiation = "Contract Negotiation",
        .onboarding = "Onboarding",
        .building_integration = "Building Integration",
        .qualified = "Qualified",
        .on_hold = "On-hold",
        .technical_validation = "Technical Validation",
        .business_validation = "Business Validation",
        .committed = "Committed",
        .launched = "Launched",
        .deferred_to_partner = "Deferred to Partner",
        .closed_lost = "Closed Lost",
        .completed = "Completed",
        .closed_incomplete = "Closed Incomplete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "Not Started",
            .in_progress => "In Progress",
            .prospect => "Prospect",
            .engaged => "Engaged",
            .identified => "Identified",
            .qualify => "Qualify",
            .research => "Research",
            .seller_engaged => "Seller Engaged",
            .evaluating => "Evaluating",
            .seller_registered => "Seller Registered",
            .term_sheet_negotiation => "Term Sheet Negotiation",
            .contract_negotiation => "Contract Negotiation",
            .onboarding => "Onboarding",
            .building_integration => "Building Integration",
            .qualified => "Qualified",
            .on_hold => "On-hold",
            .technical_validation => "Technical Validation",
            .business_validation => "Business Validation",
            .committed => "Committed",
            .launched => "Launched",
            .deferred_to_partner => "Deferred to Partner",
            .closed_lost => "Closed Lost",
            .completed => "Completed",
            .closed_incomplete => "Closed Incomplete",
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
