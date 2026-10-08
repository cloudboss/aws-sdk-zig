const AmazonMachineImageFulfillmentOption = @import("amazon_machine_image_fulfillment_option.zig").AmazonMachineImageFulfillmentOption;
const ApiFulfillmentOption = @import("api_fulfillment_option.zig").ApiFulfillmentOption;
const CloudFormationFulfillmentOption = @import("cloud_formation_fulfillment_option.zig").CloudFormationFulfillmentOption;
const ContainerFulfillmentOption = @import("container_fulfillment_option.zig").ContainerFulfillmentOption;
const DataExchangeFulfillmentOption = @import("data_exchange_fulfillment_option.zig").DataExchangeFulfillmentOption;
const Ec2ImageBuilderComponentFulfillmentOption = @import("ec_2_image_builder_component_fulfillment_option.zig").Ec2ImageBuilderComponentFulfillmentOption;
const EksAddOnFulfillmentOption = @import("eks_add_on_fulfillment_option.zig").EksAddOnFulfillmentOption;
const HelmFulfillmentOption = @import("helm_fulfillment_option.zig").HelmFulfillmentOption;
const ProfessionalServicesFulfillmentOption = @import("professional_services_fulfillment_option.zig").ProfessionalServicesFulfillmentOption;
const SaasFulfillmentOption = @import("saas_fulfillment_option.zig").SaasFulfillmentOption;
const SageMakerAlgorithmFulfillmentOption = @import("sage_maker_algorithm_fulfillment_option.zig").SageMakerAlgorithmFulfillmentOption;
const SageMakerModelFulfillmentOption = @import("sage_maker_model_fulfillment_option.zig").SageMakerModelFulfillmentOption;

/// Describes a fulfillment option for a product. Each element contains exactly
/// one fulfillment option type.
pub const FulfillmentOption = union(enum) {
    /// An Amazon Machine Image (AMI) fulfillment option for EC2 deployment.
    amazon_machine_image_fulfillment_option: ?AmazonMachineImageFulfillmentOption,
    /// An API-based fulfillment option for programmatic integration.
    api_fulfillment_option: ?ApiFulfillmentOption,
    /// An AWS CloudFormation template fulfillment option for infrastructure
    /// deployment.
    cloud_formation_fulfillment_option: ?CloudFormationFulfillmentOption,
    /// A container image fulfillment option for container-based deployment.
    container_fulfillment_option: ?ContainerFulfillmentOption,
    /// An AWS Data Exchange fulfillment option for data set delivery.
    data_exchange_fulfillment_option: ?DataExchangeFulfillmentOption,
    /// An EC2 Image Builder component fulfillment option.
    ec_2_image_builder_component_fulfillment_option: ?Ec2ImageBuilderComponentFulfillmentOption,
    /// An Amazon EKS add-on fulfillment option.
    eks_add_on_fulfillment_option: ?EksAddOnFulfillmentOption,
    /// A Helm chart fulfillment option for Kubernetes deployment.
    helm_fulfillment_option: ?HelmFulfillmentOption,
    /// A professional services fulfillment option.
    professional_services_fulfillment_option: ?ProfessionalServicesFulfillmentOption,
    /// A Software as a Service (SaaS) fulfillment option.
    saas_fulfillment_option: ?SaasFulfillmentOption,
    /// An Amazon SageMaker algorithm fulfillment option.
    sage_maker_algorithm_fulfillment_option: ?SageMakerAlgorithmFulfillmentOption,
    /// An Amazon SageMaker model fulfillment option.
    sage_maker_model_fulfillment_option: ?SageMakerModelFulfillmentOption,

    pub const json_field_names = .{
        .amazon_machine_image_fulfillment_option = "amazonMachineImageFulfillmentOption",
        .api_fulfillment_option = "apiFulfillmentOption",
        .cloud_formation_fulfillment_option = "cloudFormationFulfillmentOption",
        .container_fulfillment_option = "containerFulfillmentOption",
        .data_exchange_fulfillment_option = "dataExchangeFulfillmentOption",
        .ec_2_image_builder_component_fulfillment_option = "ec2ImageBuilderComponentFulfillmentOption",
        .eks_add_on_fulfillment_option = "eksAddOnFulfillmentOption",
        .helm_fulfillment_option = "helmFulfillmentOption",
        .professional_services_fulfillment_option = "professionalServicesFulfillmentOption",
        .saas_fulfillment_option = "saasFulfillmentOption",
        .sage_maker_algorithm_fulfillment_option = "sageMakerAlgorithmFulfillmentOption",
        .sage_maker_model_fulfillment_option = "sageMakerModelFulfillmentOption",
    };
};
