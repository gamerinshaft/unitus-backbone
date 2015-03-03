define ['jquery', 'backbone'], ($, Backbone) ->
  class Profile extends Backbone.Model
    defaults:
      BelongedSchool: '' #CanAccess, Content, DisclosureConfig
      CreatedDateInfo: '' #作成日
      CreatedDateInfoByDateOffset: ''　#作成した日から何日
      CurrentGrade: '' #学年
      Email: '' #CanAccess, Content, DisclosureConfig
      Faculty: '' #学部, CanAccess, Content, DisclosureConfig
      GithubProfile: '' #AssociationEnabled, #RepositoryCount
      Major: '' #CanAccess, Content, DisclosureConfig
      Notes: ''
      Url: '' #CanAccess, Content, DisclosureConfig
      UserName: ''

      #original
      IsSelf: true