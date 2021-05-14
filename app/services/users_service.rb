class UsersService
	class << self
		def UserListAll(page)
			@users = UsersRepository.UserListAll(page)
		end

		def newUser
			@user = UsersRepository.newUser
		end

		def createUser(user,current_user)
			saveUser = UsersRepository.createUser(user,current_user)
		end

		def findUserById(id)
			@user = UsersRepository.findUserById(id)
		end

		def destroyUser(id)
			@destroyUser = UsersRepository.findUserById(id)
			destroyUser = UsersRepository.destroyUser(@destroyUser)
		end

		def searchUser(params)
		    name = params[:name]
		    email = params[:email]
		    created_from = params[:created_from]
		    created_to = params[:created_to]
		    users = UsersRepository.searchuser(name, email, created_from, created_to)
	    end

	    def updateProfile(user_profile_form)
	    	user = findUserById(user_profile_form[:id])
	    	updateUser = UsersRepository.updateUser(user,user_profile_form)
	    end
	end
end