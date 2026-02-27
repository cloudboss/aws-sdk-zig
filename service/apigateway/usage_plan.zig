const aws = @import("aws");

const ApiStage = @import("api_stage.zig").ApiStage;
const QuotaSettings = @import("quota_settings.zig").QuotaSettings;
const ThrottleSettings = @import("throttle_settings.zig").ThrottleSettings;

/// Represents a usage plan used to specify who can assess associated API
/// stages. Optionally, target request rate and quota limits can be set.
/// In some cases clients can exceed the targets that you set. Don’t rely on
/// usage plans to control costs.
/// Consider using [Amazon Web Services
/// Budgets](https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-managing-costs.html) to monitor costs
/// and
/// [WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html) to manage API requests.
pub const UsagePlan = struct {
    /// The associated API stages of a usage plan.
    api_stages: ?[]const ApiStage,

    /// The description of a usage plan.
    description: ?[]const u8,

    /// The identifier of a UsagePlan resource.
    id: ?[]const u8,

    /// The name of a usage plan.
    name: ?[]const u8,

    /// The Amazon Web Services Marketplace product identifier to associate with the
    /// usage plan as a SaaS product on the Amazon Web Services Marketplace.
    product_code: ?[]const u8,

    /// The target maximum number of permitted requests per a given unit time
    /// interval.
    quota: ?QuotaSettings,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// A map containing method level throttling information for API stage in a
    /// usage plan.
    throttle: ?ThrottleSettings,

    pub const json_field_names = .{
        .api_stages = "apiStages",
        .description = "description",
        .id = "id",
        .name = "name",
        .product_code = "productCode",
        .quota = "quota",
        .tags = "tags",
        .throttle = "throttle",
    };
};
