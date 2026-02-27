const UserContext = @import("user_context.zig").UserContext;
const ProjectStatus = @import("project_status.zig").ProjectStatus;
const ServiceCatalogProvisionedProductDetails = @import("service_catalog_provisioned_product_details.zig").ServiceCatalogProvisionedProductDetails;
const ServiceCatalogProvisioningDetails = @import("service_catalog_provisioning_details.zig").ServiceCatalogProvisioningDetails;
const Tag = @import("tag.zig").Tag;
const TemplateProviderDetail = @import("template_provider_detail.zig").TemplateProviderDetail;

/// The properties of a project as returned by the Search API.
pub const Project = struct {
    /// Who created the project.
    created_by: ?UserContext,

    /// A timestamp specifying when the project was created.
    creation_time: ?i64,

    last_modified_by: ?UserContext,

    /// A timestamp container for when the project was last modified.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the project.
    project_arn: ?[]const u8,

    /// The description of the project.
    project_description: ?[]const u8,

    /// The ID of the project.
    project_id: ?[]const u8,

    /// The name of the project.
    project_name: ?[]const u8,

    /// The status of the project.
    project_status: ?ProjectStatus,

    service_catalog_provisioned_product_details: ?ServiceCatalogProvisionedProductDetails,

    service_catalog_provisioning_details: ?ServiceCatalogProvisioningDetails,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag,

    /// An array of template providers associated with the project.
    template_provider_details: ?[]const TemplateProviderDetail,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .project_arn = "ProjectArn",
        .project_description = "ProjectDescription",
        .project_id = "ProjectId",
        .project_name = "ProjectName",
        .project_status = "ProjectStatus",
        .service_catalog_provisioned_product_details = "ServiceCatalogProvisionedProductDetails",
        .service_catalog_provisioning_details = "ServiceCatalogProvisioningDetails",
        .tags = "Tags",
        .template_provider_details = "TemplateProviderDetails",
    };
};
