pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const DescribeAgreementInput = @import("describe_agreement.zig").DescribeAgreementInput;
pub const DescribeAgreementOutput = @import("describe_agreement.zig").DescribeAgreementOutput;
pub const GetAgreementTermsInput = @import("get_agreement_terms.zig").GetAgreementTermsInput;
pub const GetAgreementTermsOutput = @import("get_agreement_terms.zig").GetAgreementTermsOutput;
pub const SearchAgreementsInput = @import("search_agreements.zig").SearchAgreementsInput;
pub const SearchAgreementsOutput = @import("search_agreements.zig").SearchAgreementsOutput;
