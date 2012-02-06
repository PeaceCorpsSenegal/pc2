# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

settings = Setting.create!(
                            [
                              { :property => 'country', :value => 'Senegal' },
                              { :property => 'organization', :value => 'Peace Corps' }
                            ]
                          )
groups = Group.create!(
                       [
                          { :name => 'User' },
                          { :name => 'Administrator' },
                          { :name => 'Moderator' },
                          { :name => 'Staff' }
                        ]
                      )
privileges = Privilege.create!(
                               [
                                  { name: 'Edit', description: 'Ability to edit.' },
                                  { name: 'Delete', description: 'Ability to delete.' },
                                  { name: 'View', description: 'Ability to view.'},
                                  { name: 'Create', description: 'Ability to view.'}
                                ]
                              )
scopes = Scope.create!(
                       [
                         { name: 'Page', title: 'Page', description: 'Page-related privileges.' },
                         { name: 'Module', title: 'Training Module', description: 'Ability to modify modules.' },
                         { name: 'User', title: 'User/Volunteer/Staff Profile', description: 'Ability to modify users' },
                         { name: 'Photo', title: 'Photo', description: 'Ability to modify users' },
                         { name: 'Library', title: 'Library', description: 'Ability to modify users' }
                       ]
                     )
permission = Permission.create!(
                                [
                                   { group_id: 1, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 2, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 1, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 1, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 2, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 3, privilege_id: 1, comment: 'Default, base permission. Do not edit.' }
                                ]
                              )
pcregions = Pcregion.create!(
                             [
                                { name: 'Africa', short: 'AF'},
                                { name: 'North Africa & The Middle East', short: 'NA/ME'},
                                { name: 'Eastern Europe & Central Asia', short: 'EE/CA'},
                                { name: 'Asia', short: 'AS'},
                                { name: 'The Pacific Islands', short: 'PAC'},
                                { name: 'The Caribbean', short: 'CAB'},
                                { name: 'Central America & Mexico', short: 'CA/M'},
                                { name: 'South America', short: 'SA'}
                             ]
                           )
sectors = Sector.create!(
                          [
                            { name: 'Agroforestry Extension' },
                            { name: 'Small Enterprise Development' },
                            { name: 'Urban Agriculture' },
                            { name: 'Rural Agriculture' },
                            { name: 'Eco-tourism' },
                            { name: 'Health Education' },
                            { name: 'Environmental Education' }
                          ]
)

pages = Page.create!(
                     [
                        { title: 'Disclaimer',
                          description: 'Legal stuff.',
                          content: 'The contents of this web site do not reflect in any way the positions of the U.S. Government or the United States Peace Corps. This web site is managed and supported by Peace Corps Volunteers and our supporters. It is not a U.S. Government web site.',
                          system: true,
                          language_id: 2 },
                        { title: 'Privacy Policy',
                          description: 'Your rights.',
                          content: "We will never give, sell, or in any way communicate any personal information to anyone, save with the owner of said information's express permission.",
                          system: true,
                          language_id: 2 },
                        { title: 'Support',
                          description: 'Come get help!',
                          content: 'Support is here!',
                          system: true,
                          language_id: 2 },
                        { title: 'Security',
                          description: 'How we protect our information.',
                          content: 'All content hosted through this application is safe and secure. For more information please view our Privacy Policy.',
                          system: true,
                          language_id: 2 },
                        { title: 'About us',
                          description: 'A little bit about us.',
                          content: "This website is running the open source Peace Corps App, currently in pre-alpha release. \nLicense \nPC Web App is copyright John F. Brown, 2011, and files herein are licensed under the Affero General Public License version 3, the text of which can be found in GNU-AGPL-3.0, or any later version of the AGPL, unless otherwise noted. Components of PC Web App, including CodeIgniter, PHP Markdown and JQuery, are licensed separately. All unmodified files from these and other sources retain their original copyright and license notices: see the relevant individual files.",
                          system: true,
                          language_id: 2 },
                        { title: 'Calendar',
                          description: 'Our calendar.',
                          content: 'Calender goes here.',
                          system: true,
                          language_id: 2 }
])

jack = User.create!(
                    :name => 'Jack Brown',
                    :email => 'jack@brownjohnf.com',
                    :country => 'SN',
                    :bio => '# Bio Here')
jack.volunteers.create!(
                        :local_name => 'Babakar Ndiaye',
                        :emphasis => 'Media',
                        :projects => 'Website, How-To Videos',
                        :sector_id => 1,
                        :site_id => 1
                       )
jack.blogs.create!(
                    :title => 'Senegal et al',
                    :description => 'Info about my life in Senegal.',
                    :url => 'http://senegaletal.blogspot.com'
                  )
jack.memberships.create!(
                          [
                            { :group_id => 2 },
                            { :group_id => 3 }
                          ]
                        )
languages = Language.create!(
                             [
                               { :name => 'Sereer', :code => 'SE', :description => 'A lovely little language.' },
                               { :name => 'English', :code => 'EN', :description => 'The greatest language in the world.' }
                              ]
                           )

Page.rebuild!
