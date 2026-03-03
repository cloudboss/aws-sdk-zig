const DeliveryModel = @import("delivery_model.zig").DeliveryModel;
const ExpectedCustomerSpend = @import("expected_customer_spend.zig").ExpectedCustomerSpend;

/// An object that contains a `Project` object's subset of fields.
pub const ProjectSummary = struct {
    /// Specifies your solution or service's deployment or consumption model in the
    /// `Opportunity`'s context. You can select multiple options.
    ///
    /// Options' descriptions from the `Delivery Model` field are:
    ///
    /// * SaaS or PaaS: Your Amazon Web Services based solution deployed as SaaS or
    ///   PaaS in your Amazon Web Services environment.
    /// * BYOL or AMI: Your Amazon Web Services based solution deployed as BYOL or
    ///   AMI in the end customer's Amazon Web Services environment.
    /// * Managed Services: The end customer's Amazon Web Services business
    ///   management (For example: Consulting, design, implementation, billing
    ///   support, cost optimization, technical support).
    /// * Professional Services: Offerings to help enterprise end customers achieve
    ///   specific business outcomes for enterprise cloud adoption (For example:
    ///   Advisory or transformation planning).
    /// * Resell: Amazon Web Services accounts and billing management for your
    ///   customers.
    /// * Other: Delivery model not described above.
    delivery_models: ?[]const DeliveryModel = null,

    /// Provides a summary of the expected customer spend for the project, offering
    /// a high-level view of the potential financial impact.
    expected_customer_spend: ?[]const ExpectedCustomerSpend = null,

    pub const json_field_names = .{
        .delivery_models = "DeliveryModels",
        .expected_customer_spend = "ExpectedCustomerSpend",
    };
};
