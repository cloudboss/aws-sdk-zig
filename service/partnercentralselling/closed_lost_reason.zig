const std = @import("std");

pub const ClosedLostReason = enum {
    customer_deficiency,
    delay_cancellation_of_project,
    legal_tax_regulatory,
    lost_to_competitor_google,
    lost_to_competitor_microsoft,
    lost_to_competitor_softlayer,
    lost_to_competitor_vmware,
    lost_to_competitor_other,
    no_opportunity,
    on_premises_deployment,
    partner_gap,
    price,
    security_compliance,
    technical_limitations,
    customer_experience,
    other,
    peoplerelationshipgovernance,
    producttechnology,
    financialcommercial,

    pub const json_field_names = .{
        .customer_deficiency = "Customer Deficiency",
        .delay_cancellation_of_project = "Delay / Cancellation of Project",
        .legal_tax_regulatory = "Legal / Tax / Regulatory",
        .lost_to_competitor_google = "Lost to Competitor - Google",
        .lost_to_competitor_microsoft = "Lost to Competitor - Microsoft",
        .lost_to_competitor_softlayer = "Lost to Competitor - SoftLayer",
        .lost_to_competitor_vmware = "Lost to Competitor - VMWare",
        .lost_to_competitor_other = "Lost to Competitor - Other",
        .no_opportunity = "No Opportunity",
        .on_premises_deployment = "On Premises Deployment",
        .partner_gap = "Partner Gap",
        .price = "Price",
        .security_compliance = "Security / Compliance",
        .technical_limitations = "Technical Limitations",
        .customer_experience = "Customer Experience",
        .other = "Other",
        .peoplerelationshipgovernance = "People/Relationship/Governance",
        .producttechnology = "Product/Technology",
        .financialcommercial = "Financial/Commercial",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_deficiency => "Customer Deficiency",
            .delay_cancellation_of_project => "Delay / Cancellation of Project",
            .legal_tax_regulatory => "Legal / Tax / Regulatory",
            .lost_to_competitor_google => "Lost to Competitor - Google",
            .lost_to_competitor_microsoft => "Lost to Competitor - Microsoft",
            .lost_to_competitor_softlayer => "Lost to Competitor - SoftLayer",
            .lost_to_competitor_vmware => "Lost to Competitor - VMWare",
            .lost_to_competitor_other => "Lost to Competitor - Other",
            .no_opportunity => "No Opportunity",
            .on_premises_deployment => "On Premises Deployment",
            .partner_gap => "Partner Gap",
            .price => "Price",
            .security_compliance => "Security / Compliance",
            .technical_limitations => "Technical Limitations",
            .customer_experience => "Customer Experience",
            .other => "Other",
            .peoplerelationshipgovernance => "People/Relationship/Governance",
            .producttechnology => "Product/Technology",
            .financialcommercial => "Financial/Commercial",
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
