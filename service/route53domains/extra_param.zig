const ExtraParamName = @import("extra_param_name.zig").ExtraParamName;

/// ExtraParam includes the following elements.
pub const ExtraParam = struct {
    /// The name of an additional parameter that is required by a top-level domain.
    /// Here are
    /// the top-level domains that require additional parameters and the names of
    /// the parameters
    /// that they require:
    ///
    /// **.au, .com.au, and .net.au**
    ///
    /// * `AU_REGISTRANT_NAME`
    ///
    /// * `AU_ID_NUMBER`
    ///
    /// * `AU_ID_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `ABN` (Australian business number)
    ///
    /// * `ACN` (Australian company number)
    ///
    /// * `TM` (Trademark number)
    ///
    /// * `AU_ELIGIBILITY_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * CHARITABLE_TRUST (Charitable trust)
    ///
    /// * CHARITY (Charity)
    ///
    /// * CHILD_CARE_CENTRE (Child care centre)
    ///
    /// * CLUB (Club)
    ///
    /// * COMMERCIAL_STATUTORY_BODY (Commercial statutory body)
    ///
    /// * COMMONWEALTH_ENTITY (Commonwealth entity)
    ///
    /// * COMPANY (Company)
    ///
    /// * COMPANY_LIMITED_BY_GUARANTEE (Company limited by guarantee)
    ///
    /// * EDUCATIONAL_INSTITUTION (Educational institution)
    ///
    /// * GOVERNMENT_SCHOOL (Government school)
    ///
    /// * HIGHER_EDUCATION_INSTITUTION (Higher education institution)
    ///
    /// * INCORPORATED_ASSOCIATION (Incorporated association)
    ///
    /// * INDIGENOUS_CORPORATION (Indigenous corporation)
    ///
    /// * INDUSTRY_BODY (Industry body)
    ///
    /// * INDUSTRY_ORGANISATION (Industry association)
    ///
    /// * NATIONAL_BODY (National body)
    ///
    /// * NON_DISTRIBUTING_COOPERATIVE (Non-distributing cooperative)
    ///
    /// * NON_GOVERNMENT_SCHOOL (Non-government school)
    ///
    /// * NON_PROFIT_ORGANISATION (Non-profit organisation)
    ///
    /// * NON_TRADING_COOPERATIVE (Non-trading cooperative)
    ///
    /// * NOT_FOR_PROFIT_COMMUNITY_GROUP (Not-for-profit community group)
    ///
    /// * PARTNERSHIP (Partnership)
    ///
    /// * PEAK_STATE_TERRITORY_BODY (Peak state/territory body)
    ///
    /// * PENDING_TM_OWNER (Pending TM owner)
    ///
    /// * POLITICAL_PARTY (Political party)
    ///
    /// * PRESCHOOL (Pre-school)
    ///
    /// * PUBLIC_PRIVATE_ANCILLARY_FUND (Public/private ancillary fund)
    ///
    /// * REGISTERED_BUSINESS (Registered business)
    ///
    /// * REGISTERED_ORGANISATION (Registered organisation)
    ///
    /// * REGISTRABLE_BODY (Registrable body)
    ///
    /// * RESEARCH_ORGANISATION (Research organisation)
    ///
    /// * STATUTORY_BODY (Statutory body)
    ///
    /// * TRADE_UNION (Trade union)
    ///
    /// * TRADEMARK_OWNER (Trademark owner)
    ///
    /// * TRADING_COOPERATIVE (Trading cooperative)
    ///
    /// * TRAINING_ORGANISATION (Training organisation)
    ///
    /// * TRUST (Trust)
    ///
    /// * UNINCORPORATED_ASSOCIATION (Unincorporated association)
    ///
    /// * EDUCATION_AND_CARE_SERVICES_CHILDCARE (Education and care services (child
    ///   care))
    ///
    /// * GOVERNMENT_BODY (Government body)
    ///
    /// * PROVIDER_OF_NON_ACCREDITED_TRAINING (Provider of non-accredited training)
    ///
    /// * RELIGIOUS_CHURCH_GROUP (Religious/church group)
    ///
    /// * SOLE_TRADER (Sole trader)
    ///
    /// * `AU_POLICY_REASON`
    ///
    /// Valid values include the following:
    ///
    /// * `POLICY_REASON_1`
    ///
    /// `POLICY_REASON_2`
    ///
    /// **.ca**
    ///
    /// * `BRAND_NUMBER`
    ///
    /// * `CA_BUSINESS_ENTITY_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `BANK` (Bank)
    ///
    /// * `COMMERCIAL_COMPANY` (Commercial
    /// company)
    ///
    /// * `COMPANY` (Company)
    ///
    /// * `COOPERATION` (Cooperation)
    ///
    /// * `COOPERATIVE` (Cooperative)
    ///
    /// * `COOPRIX` (Cooprix)
    ///
    /// * `CORP` (Corporation)
    ///
    /// * `CREDIT_UNION` (Credit union)
    ///
    /// * `FOMIA` (Federation of mutual insurance
    /// associations)
    ///
    /// * `INC` (Incorporated)
    ///
    /// * `LTD` (Limited)
    ///
    /// * `LTEE` (Limitée)
    ///
    /// * `LLC` (Limited liability corporation)
    ///
    /// * `LLP` (Limited liability partnership)
    ///
    /// * `LTE` (Lte.)
    ///
    /// * `MBA` (Mutual benefit association)
    ///
    /// * `MIC` (Mutual insurance company)
    ///
    /// * `NFP` (Not-for-profit corporation)
    ///
    /// * `SA` (S.A.)
    ///
    /// * `SAVINGS_COMPANY` (Savings company)
    ///
    /// * `SAVINGS_UNION` (Savings union)
    ///
    /// * `SARL` (Société à responsabilité
    /// limitée)
    ///
    /// * `TRUST` (Trust)
    ///
    /// * `ULC` (Unlimited liability corporation)
    ///
    /// * `CA_LEGAL_TYPE`
    ///
    /// When `ContactType` is `PERSON`, valid values
    /// include the following:
    ///
    /// * `ABO` (Aboriginal Peoples indigenous to
    /// Canada)
    ///
    /// * `CCT` (Canadian citizen)
    ///
    /// * `LGR` (Legal Representative of a Canadian
    /// Citizen or Permanent Resident)
    ///
    /// * `RES` (Permanent resident of Canada)
    ///
    /// When `ContactType` is a value other than
    /// `PERSON`, valid values include the following:
    ///
    /// * `ASS` (Canadian unincorporated
    /// association)
    ///
    /// * `CCO` (Canadian corporation)
    ///
    /// * `EDU` (Canadian educational institution)
    ///
    /// * `GOV` (Government or government entity in
    /// Canada)
    ///
    /// * `HOP` (Canadian Hospital)
    ///
    /// * `INB` (Indian Band recognized by the Indian Act
    /// of Canada)
    ///
    /// * `LAM` (Canadian Library, Archive, or
    /// Museum)
    ///
    /// * `MAJ` (Her/His Majesty the Queen/King)
    ///
    /// * `OMK` (Official mark registered in
    /// Canada)
    ///
    /// * `PLT` (Canadian Political Party)
    ///
    /// * `PRT` (Partnership Registered in Canada)
    ///
    /// * `TDM` (Trademark registered in Canada)
    ///
    /// * `TRD` (Canadian Trade Union)
    ///
    /// * `TRS` (Trust established in Canada)
    ///
    /// **.es**
    ///
    /// * `ES_IDENTIFICATION`
    ///
    /// The value of `ES_IDENTIFICATION` depends on the
    /// following values:
    ///
    /// * The value of `ES_LEGAL_FORM`
    ///
    /// * The value of `ES_IDENTIFICATION_TYPE`
    ///
    /// **If `ES_LEGAL_FORM` is any value
    /// other than `INDIVIDUAL`:**
    ///
    /// * Specify 1 letter + 8 numbers (CIF [Certificado de
    /// Identificación Fiscal])
    ///
    /// * Example: B12345678
    ///
    /// **If `ES_LEGAL_FORM` is
    /// `INDIVIDUAL`, the value that you specify for
    /// `ES_IDENTIFICATION` depends on the value of
    /// `ES_IDENTIFICATION_TYPE`:**
    ///
    /// * If `ES_IDENTIFICATION_TYPE` is
    /// `DNI_AND_NIF` (for Spanish contacts):
    ///
    /// * Specify 8 numbers + 1 letter (DNI [Documento
    /// Nacional de Identidad], NIF [Número de
    /// Identificación Fiscal])
    ///
    /// * Example: 12345678M
    ///
    /// * If `ES_IDENTIFICATION_TYPE` is `NIE`
    /// (for foreigners with legal residence):
    ///
    /// * Specify 1 letter + 7 numbers + 1 letter ( NIE
    /// [Número de Identidad de Extranjero])
    ///
    /// * Example: Y1234567X
    ///
    /// * If `ES_IDENTIFICATION_TYPE` is
    /// `OTHER` (for contacts outside of
    /// Spain):
    ///
    /// * Specify a passport number, drivers license number,
    /// or national identity card number
    ///
    /// * `ES_IDENTIFICATION_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `DNI_AND_NIF` (For Spanish contacts)
    ///
    /// * `NIE` (For foreigners with legal
    /// residence)
    ///
    /// * `OTHER` (For contacts outside of Spain)
    ///
    /// * `ES_LEGAL_FORM`
    ///
    /// Valid values include the following:
    ///
    /// * `ASSOCIATION`
    ///
    /// * `CENTRAL_GOVERNMENT_BODY`
    ///
    /// * `CIVIL_SOCIETY`
    ///
    /// * `COMMUNITY_OF_OWNERS`
    ///
    /// * `COMMUNITY_PROPERTY`
    ///
    /// * `CONSULATE`
    ///
    /// * `COOPERATIVE`
    ///
    /// * `DESIGNATION_OF_ORIGIN_SUPERVISORY_COUNCIL`
    ///
    /// * `ECONOMIC_INTEREST_GROUP`
    ///
    /// * `EMBASSY`
    ///
    /// * `ENTITY_MANAGING_NATURAL_AREAS`
    ///
    /// * `FARM_PARTNERSHIP`
    ///
    /// * `FOUNDATION`
    ///
    /// * `GENERAL_AND_LIMITED_PARTNERSHIP`
    ///
    /// * `GENERAL_PARTNERSHIP`
    ///
    /// * `INDIVIDUAL`
    ///
    /// * `LIMITED_COMPANY`
    ///
    /// * `LOCAL_AUTHORITY`
    ///
    /// * `LOCAL_PUBLIC_ENTITY`
    ///
    /// * `MUTUAL_INSURANCE_COMPANY`
    ///
    /// * `NATIONAL_PUBLIC_ENTITY`
    ///
    /// * `ORDER_OR_RELIGIOUS_INSTITUTION`
    ///
    /// * `OTHERS (Only for contacts outside of
    /// Spain)`
    ///
    /// * `POLITICAL_PARTY`
    ///
    /// * `PROFESSIONAL_ASSOCIATION`
    ///
    /// * `PUBLIC_LAW_ASSOCIATION`
    ///
    /// * `PUBLIC_LIMITED_COMPANY`
    ///
    /// * `REGIONAL_GOVERNMENT_BODY`
    ///
    /// * `REGIONAL_PUBLIC_ENTITY`
    ///
    /// * `SAVINGS_BANK`
    ///
    /// * `SPANISH_OFFICE`
    ///
    /// * `SPORTS_ASSOCIATION`
    ///
    /// * `SPORTS_FEDERATION`
    ///
    /// * `SPORTS_LIMITED_COMPANY`
    ///
    /// * `TEMPORARY_ALLIANCE_OF_ENTERPRISES`
    ///
    /// * `TRADE_UNION`
    ///
    /// * `WORKER_OWNED_COMPANY`
    ///
    /// * `WORKER_OWNED_LIMITED_COMPANY`
    ///
    /// **.eu**
    ///
    /// * ` EU_COUNTRY_OF_CITIZENSHIP`
    ///
    /// **.fi**
    ///
    /// * `BIRTH_DATE_IN_YYYY_MM_DD`
    ///
    /// * `FI_BUSINESS_NUMBER`
    ///
    /// * `FI_ID_NUMBER`
    ///
    /// * `FI_NATIONALITY`
    ///
    /// Valid values include the following:
    ///
    /// * `FINNISH`
    ///
    /// * `NOT_FINNISH`
    ///
    /// * `FI_ORGANIZATION_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `COMPANY`
    ///
    /// * `CORPORATION`
    ///
    /// * `GOVERNMENT`
    ///
    /// * `INSTITUTION`
    ///
    /// * `POLITICAL_PARTY`
    ///
    /// * `PUBLIC_COMMUNITY`
    ///
    /// * `TOWNSHIP`
    ///
    /// **.it**
    ///
    /// * `IT_NATIONALITY`
    ///
    /// * `IT_PIN`
    ///
    /// * `IT_REGISTRANT_ENTITY_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `FOREIGNERS`
    ///
    /// * `FREELANCE_WORKERS` (Freelance workers and
    /// professionals)
    ///
    /// * `ITALIAN_COMPANIES` (Italian companies and
    /// one-person companies)
    ///
    /// * `NON_PROFIT_ORGANIZATIONS`
    ///
    /// * `OTHER_SUBJECTS`
    ///
    /// * `PUBLIC_ORGANIZATIONS`
    ///
    /// **.ru**
    ///
    /// * `BIRTH_DATE_IN_YYYY_MM_DD`
    ///
    /// * `RU_PASSPORT_DATA`
    ///
    /// **.se**
    ///
    /// * `BIRTH_COUNTRY`
    ///
    /// * `SE_ID_NUMBER`
    ///
    /// **.sg**
    ///
    /// * `SG_ID_NUMBER`
    ///
    /// **.uk, .co.uk, .me.uk, and .org.uk**
    ///
    /// * `UK_CONTACT_TYPE`
    ///
    /// Valid values include the following:
    ///
    /// * `CRC` (UK Corporation by Royal Charter)
    ///
    /// * `FCORP` (Non-UK Corporation)
    ///
    /// * `FIND` (Non-UK Individual, representing
    /// self)
    ///
    /// * `FOTHER` (Non-UK Entity that does not fit into
    /// any other category)
    ///
    /// * `GOV` (UK Government Body)
    ///
    /// * `IND` (UK Individual (representing
    /// self))
    ///
    /// * `IP` (UK Industrial/Provident Registered
    /// Company)
    ///
    /// * `LLP` (UK Limited Liability Partnership)
    ///
    /// * `LTD` (UK Limited Company)
    ///
    /// * `OTHER` (UK Entity that does not fit into any
    /// other category)
    ///
    /// * `PLC` (UK Public Limited Company)
    ///
    /// * `PTNR` (UK Partnership)
    ///
    /// * `RCHAR` (UK Registered Charity)
    ///
    /// * `SCH` (UK School)
    ///
    /// * `STAT` (UK Statutory Body)
    ///
    /// * `STRA` (UK Sole Trader)
    ///
    /// * `UK_COMPANY_NUMBER`
    ///
    /// In addition, many TLDs require a `VAT_NUMBER`.
    name: ExtraParamName,

    /// The value that corresponds with the name of an extra parameter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
