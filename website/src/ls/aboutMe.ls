angular.module 'aboutMe' ['ngMaterial', 'ngMessages', 'ngCookies']

.controller 'aboutMeController' ($http, $scope, $cookies) !->
  # 请求留言板的数据
  that = @
  $http { method: 'GET', url: '/aboutMeComments' }
  .then (response) !->
    that.comments = response.data
  , (response) !->
    console.log response

  # 设置 cookies
  $scope.comment = {}

  $scope.isKeepName = false
  $scope.comment.name = ''
  isKeepName = $cookies.get 'isKeepName'
  keepName = $cookies.get 'keepName'
  if isKeepName == 'true' && keepName != undefined
    $scope.isKeepName = true
    $scope.comment.name = keepName

  # 发送新的留言
  @submit = !->
    if document.getElementById 'textError' .getElementsByTagName '*' .length == 0 && document.getElementById 'nameError' .getElementsByTagName '*' .length == 0
      # 设置 cookies
      $cookies.put('isKeepName', $scope.isKeepName)
      $cookies.put('keepName', $scope.comment.name)

      that = @
      name = addComment.name.value
      if ($scope.isKeepName == false)
        addComment.name.value = ''
      text = addComment.text.value
      addComment.text.value = ''
      $http { method: 'POST', url: '/aboutMeComments', data: { name: name, text: text } }
      .then (response) !->
        that.comments = response.data
      , (response) !->
        console.log response
