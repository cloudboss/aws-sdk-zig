const AwsPartition = @import("aws_partition.zig").AwsPartition;
const CompetitorName = @import("competitor_name.zig").CompetitorName;
const DeliveryModel = @import("delivery_model.zig").DeliveryModel;
const ExpectedCustomerSpend = @import("expected_customer_spend.zig").ExpectedCustomerSpend;
const SalesActivity = @import("sales_activity.zig").SalesActivity;

/// An object that contains the `Opportunity`'s project details.
pub const Project = struct {
    /// Captures additional comments or information for the `Opportunity` that
    /// weren't captured in other fields.
    additional_comments: ?[]const u8 = null,

    /// Specifies the Amazon Partner Network (APN) program that influenced the
    /// `Opportunity`. APN programs refer to specific partner programs or
    /// initiatives that can impact the `Opportunity`.
    ///
    /// Valid values: `APN Immersion Days | APN Solution Space | ATO (Authority to
    /// Operate) | AWS Marketplace Campaign | IS Immersion Day SFID Program | ISV
    /// Workload Migration | Migration Acceleration Program | P3 | Partner Launch
    /// Initiative | Partner Opportunity Acceleration Funded | The Next Smart |
    /// VMware Cloud on AWS | Well-Architected | Windows | Workspaces/AppStream
    /// Accelerator Program | WWPS NDPP`
    apn_programs: ?[]const []const u8 = null,

    /// AWS partition where the opportunity will be deployed. Possible values:
    /// `aws-eusc` for AWS European Sovereign Cloud, `null` for all other
    /// partitions.
    aws_partition: ?AwsPartition = null,

    /// Name of the `Opportunity`'s competitor (if any). Use `Other` to submit a
    /// value not in the picklist.
    competitor_name: ?CompetitorName = null,

    /// Describes the problem the end customer has, and how the partner is helping.
    /// Utilize this field to provide a concise narrative that outlines the
    /// customer's business challenge or issue. Elaborate on how the partner's
    /// solution or offerings align to resolve the customer's business problem.
    /// Include relevant information about the partner's value proposition, unique
    /// selling points, and expertise to tackle the issue. Offer insights on how the
    /// proposed solution meets the customer's needs and provides value. Use concise
    /// language and precise descriptions to convey the context and significance of
    /// the `Opportunity`. The content in this field helps Amazon Web Services
    /// understand the nature of the `Opportunity` and the strategic fit of the
    /// partner's solution.
    customer_business_problem: ?[]const u8 = null,

    /// Specifies the proposed solution focus or type of workload for the
    /// Opportunity. This field captures the primary use case or objective of the
    /// proposed solution, and provides context and clarity to the addressed
    /// workload.
    ///
    /// Valid values: `AI Machine Learning and Analytics | Archiving | Big Data:
    /// Data Warehouse/Data Integration/ETL/Data Lake/BI | Blockchain | Business
    /// Applications: Mainframe Modernization | Business Applications & Contact
    /// Center | Business Applications & SAP Production | Centralized Operations
    /// Management | Cloud Management Tools | Cloud Management Tools & DevOps with
    /// Continuous Integration & Continuous Delivery (CICD) | Configuration,
    /// Compliance & Auditing | Connected Services | Containers & Serverless |
    /// Content Delivery & Edge Services | Database | Edge Computing/End User
    /// Computing | Energy | Enterprise Governance & Controls | Enterprise Resource
    /// Planning | Financial Services | Healthcare and Life Sciences | High
    /// Performance Computing | Hybrid Application Platform | Industrial Software |
    /// IOT | Manufacturing, Supply Chain and Operations | Media & High performance
    /// computing (HPC) | Migration/Database Migration | Monitoring, logging and
    /// performance | Monitoring & Observability | Networking | Outpost | SAP |
    /// Security & Compliance | Storage & Backup | Training | VMC | VMWare | Web
    /// development & DevOps`
    customer_use_case: ?[]const u8 = null,

    /// Specifies the deployment or consumption model for your solution or service
    /// in the `Opportunity`'s context. You can select multiple options.
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

    /// Represents the estimated amount that the customer is expected to spend on
    /// AWS services related to the opportunity. This helps in evaluating the
    /// potential financial value of the opportunity for AWS.
    expected_customer_spend: ?[]const ExpectedCustomerSpend = null,

    /// Only allowed when `CompetitorNames` has `Other` selected.
    other_competitor_names: ?[]const u8 = null,

    /// Specifies the offered solution for the customer's business problem when the
    /// ` RelatedEntityIdentifiers.Solutions` field value is `Other`.
    other_solution_description: ?[]const u8 = null,

    /// Specifies the current opportunity's parent opportunity identifier.
    related_opportunity_identifier: ?[]const u8 = null,

    /// Specifies the `Opportunity`'s sales activities conducted with the end
    /// customer. These activities help drive Amazon Web Services assignment
    /// priority.
    ///
    /// Valid values:
    ///
    /// * Initialized discussions with customer: Initial conversations with the
    ///   customer to understand their needs and introduce your solution.
    /// * Customer has shown interest in solution: After initial discussions, the
    ///   customer is interested in your solution.
    /// * Conducted POC/demo: You conducted a proof of concept (POC) or
    ///   demonstration of the solution for the customer.
    /// * In evaluation/planning stage: The customer is evaluating the solution and
    ///   planning potential implementation.
    /// * Agreed on solution to Business Problem: Both parties agree on how the
    ///   solution addresses the customer's business problem.
    /// * Completed Action Plan: A detailed action plan is complete and outlines the
    ///   steps for implementation.
    /// * Finalized Deployment Need: Both parties agree with and finalized the
    ///   deployment needs.
    /// * SOW Signed: Both parties signed a statement of work (SOW), and formalize
    ///   the agreement and detail the project scope and deliverables.
    sales_activities: ?[]const SalesActivity = null,

    /// Specifies the `Opportunity`'s title or name.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_comments = "AdditionalComments",
        .apn_programs = "ApnPrograms",
        .aws_partition = "AwsPartition",
        .competitor_name = "CompetitorName",
        .customer_business_problem = "CustomerBusinessProblem",
        .customer_use_case = "CustomerUseCase",
        .delivery_models = "DeliveryModels",
        .expected_customer_spend = "ExpectedCustomerSpend",
        .other_competitor_names = "OtherCompetitorNames",
        .other_solution_description = "OtherSolutionDescription",
        .related_opportunity_identifier = "RelatedOpportunityIdentifier",
        .sales_activities = "SalesActivities",
        .title = "Title",
    };
};
